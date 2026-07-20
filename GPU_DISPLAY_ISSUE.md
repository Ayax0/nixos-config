# PC Stability Issues

## Problem

Zwei unterschiedliche Symptome beobachtet:
1. **Display-Verlust**: PC verliert Bildausgabe auf allen Monitoren. System läuft weiter (Lüfter, LEDs), kein Bild. Meist im Idle, auch während aktiver Nutzung.
2. **Spontaner Reboot**: PC startet ohne Vorwarnung komplett neu.

## Hardware-Setup

- **RX 7900 XT/XTX** (Navi 31) — PCI `0000:03:00.0`, DRM card1 → Monitore: HDMI-A-1, DP-1, DP-2, DP-3
- **RX 6400** (Navi 24) — PCI `0000:09:00.0`, DRM card0 → Monitore: HDMI-A-2, DP-4
- **Ryzen iGPU** (Granite Ridge) — PCI `0000:77:00.0`, DRM card2 → kein Monitor
- **6 Monitore** total, Hyprland/Wayland
- **64GB RAM**, kein Swap (bei 64GB kein Problem)
- **Netzteil**: be quiet! Pure Power 13 M, 1000W
- **USB**: Eurolite DMX-Interface war angeschlossen (seit 2026-06-29 getrennt)

## Diagnose (2026-06-28)

### Ursache: DCN 3.2 Display Controller Timeout

Jeder Boot seit ~Anfang Juni zeigt:
```
amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 100 tries - dcn32_program_compbuf_size
```

DCN 3.2 ist der Display Controller in Navi 31 GPUs. Der Timeout beim Programmieren des Compositor-Buffers ist ein bekanntes Problem, besonders bei Multi-Monitor-Setups. GPU Runtime Power Management (runpm) kann das verschlimmern — GPU geht in Sleep, Display Controller crashed beim Aufwachen.

### Boot-Logs bestätigten Crashes

Boot -1 endete abrupt ohne Shutdown-Sequenz nach nur ~1.5h Laufzeit. Keine MCE (Machine Check Exception), keine Kernel Panics in den Logs — deutet auf Display Controller Hang, nicht auf Hardware-Defekt.

## Durchgeführte Fixes (2026-06-28)

### 1. Plymouth deaktiviert (`graphics.nix`)
Plymouth fügte `quiet splash loglevel=3` zu Boot-Params hinzu und unterdrückte Kernel-Meldungen. Ohne Plymouth sind GPU-Fehler in journalctl sichtbar.

### 2. `amdgpu.runpm=0` (`configuration.nix`)
GPU Runtime Power Management deaktiviert. Verhindert problematische Sleep/Wake-Zyklen des Display Controllers.

### 3. Kernel auf `linuxPackages_latest` (`configuration.nix`)
Von Kernel 6.12.91 auf neuesten stabilen Kernel. Kernel 6.13-6.15 enthielten zahlreiche DCN 3.2 Fixes für Navi 31.

## Zweiter Vorfall (2026-06-29): Spontaner Reboot

### Symptom

PC hat nach ~27h Uptime (Boot -1: 2026-06-28 09:19 bis 2026-06-29 12:19) spontan rebootet. Kein Display-Verlust, sondern kompletter Neustart. Neuer Kernel 7.0.10 war aktiv.

### Reset-Reason aus Kernel-Log

```
x86/amd: Previous system reset reason [0x00200800]: ACPI power state transition occurred
```

Kein GPU-Fehler, kein Kernel-Panic, kein OOM, kein Thermal-Event. ACPI Power State Transition = Hardware hat Reboot ausgelöst.

### Verdacht: Eurolite DMX USB-Interface

`olad` (Open Lighting Architecture) spammte alle 20 Sekunden Timeout-Fehler:
```
plugins/usbpro/UsbProWidgetDetector.cpp:323: USB Widget didn't respond to messages
common/io/TimeoutManager.cpp:92: timeout already in remove set
```

Defektes/instabiles USB-Gerät kann ACPI Power State Transitions auslösen. DMX-Interface wurde nach diesem Vorfall getrennt.

### Bewertung

Möglicherweise zwei separate Probleme:
- **Display-Verlust** → DCN 3.2 Bug (Kernel-Update + runpm=0 sollte fixen)
- **Spontaner Reboot** → USB-Device-Problem triggert ACPI-Reset (DMX-Interface getrennt)

## Falls es wieder passiert

### Logs prüfen nach Hard-Reset

```bash
# GPU-spezifische Fehler vom letzten Boot
journalctl -b -1 | grep -iE 'amdgpu|drm|gpu|hang|timeout|reset|fault'

# Letzte Einträge vor Crash
journalctl -b -1 | tail -50

# Prüfen ob sauberer Shutdown oder Crash
journalctl -b -1 | grep -iE 'shutdown|reboot|halt|poweroff'
# Keine Treffer = Crash/Hang

# Reset-Reason (zeigt warum Hardware rebootet hat)
journalctl -b 0 | grep -iE 'reset reason|power state'

# Machine Check Exceptions (Hardware-Defekt)
journalctl -b -1 | grep -iE 'mce|machine check|hardware error'

# Kernel Panic/Oops
journalctl -b -1 | grep -iE 'panic|oops|BUG:|RIP:'

# Thermal-Events
journalctl -b -1 | grep -iE 'thermal|temperature|overheat|therm_throt'

# OOM-Kills
journalctl -b -1 | grep -iE 'oom|out of memory|killed process'
```

### Weitere Eskalationsstufen

Falls Problem trotz Fixes bestehen bleibt:

1. **iGPU im BIOS deaktivieren** — lädt unnötig amdgpu-Instanz, könnte interferieren
2. **Einen Monitor weniger testen** — DCN 3.2 Bug korreliert mit Anzahl aktiver Display-Pipes
3. **`amdgpu.dcdebugmask=0x10`** Kernel-Param — aktiviert DCN Debug-Logging
4. **`amdgpu.gpu_recovery=1`** Kernel-Param — erlaubt GPU-Reset statt komplettem Hang
5. **Nur RX 7900 Monitore temporär auf RX 6400 umstecken** — isoliert ob Problem GPU-spezifisch ist
6. **USB-Geräte einzeln testen** — nacheinander anschliessen, olad/USB-Timeout-Spam in journalctl beobachten
7. **BIOS: ErP Ready / Power-States prüfen** — aggressive ACPI-Settings können spontane Reboots auslösen
8. **Netzteil-Rails prüfen** — bei Instabilität unter Last (unwahrscheinlich bei 1000W, aber nicht ausgeschlossen)
