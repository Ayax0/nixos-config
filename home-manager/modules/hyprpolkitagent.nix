{ ... }:

{
  # finds its session through logind; soteria needs XDG_SESSION_ID, which uwsm keeps out
  # of the systemd user environment
  services.hyprpolkitagent.enable = true;
}
