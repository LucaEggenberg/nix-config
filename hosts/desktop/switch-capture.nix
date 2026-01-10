{ pkgs, ... }:

let
  switchHd60x = pkgs.writeShellScriptBin "switch-hd60x" ''
    set -euo pipefail

    PW_LINK="${pkgs.pipewire}/bin/pw-link"

    IN_NODE="alsa_input.usb-Elgato_Elgato_HD60_X_A00XB51921VR9N-02.analog-stereo"
    OUT_NODE="easyeffects_sink"
    # If you ever want to bypass EasyEffects and go straight to iFi, use:
    # OUT_NODE="alsa_output.usb-iFi__by_AMR__iFi__by_AMR__HD_USB_Audio_0003-00.analog-stereo"

    # Wait (briefly) for PipeWire + the Elgato node to exist
    for i in $(seq 1 120); do
      if $PW_LINK -l | grep -q "$IN_NODE"; then
        break
      fi
      sleep 0.1
    done

    # Grab ports dynamically (avoids hardcoding port suffixes)
    IN_PORTS="$($PW_LINK -i | grep "^$IN_NODE:" || true)"
    OUT_PORTS="$($PW_LINK -o | grep "^$OUT_NODE:" || true)"

    if [ -n "$IN_PORTS" ] && [ -n "$OUT_PORTS" ]; then
      IN_FL="$(echo "$IN_PORTS"  | grep -m1 -E ":capture_FL|:input_FL" | awk '{print $1}')"
      IN_FR="$(echo "$IN_PORTS"  | grep -m1 -E ":capture_FR|:input_FR" | awk '{print $1}')"
      OUT_FL="$(echo "$OUT_PORTS" | grep -m1 -E ":playback_FL|:monitor_FL" | awk '{print $1}')"
      OUT_FR="$(echo "$OUT_PORTS" | grep -m1 -E ":playback_FR|:monitor_FR" | awk '{print $1}')"

      # Link L/R (ignore errors if already linked)
      $PW_LINK "$IN_FL" "$OUT_FL" || true
      $PW_LINK "$IN_FR" "$OUT_FR" || true
    fi

    # Launch Switch video (1440p60 NV12, very low latency)
    exec ${pkgs.mpv}/bin/mpv \
      --profile=low-latency \
      --untimed \
      --cache=no \
      --demuxer-lavf-o-set=input_format=nv12 \
      --demuxer-lavf-o-set=video_size=2560x1440 \
      --demuxer-lavf-o-set=framerate=60 \
      --gpu-context=wayland \
      --fs \
      /dev/video0
  '';

  switchDesktop = pkgs.makeDesktopItem {
    name = "switch-hd60x";
    desktopName = "Nintendo Switch";
    exec = "${switchHd60x}/bin/switch-hd60x";
    terminal = false;
    categories = [ "Game" "AudioVideo" ];
  };
in
{
  environment.systemPackages = with pkgs; [
    pipewire
    mpv
    switchHd60x
    switchDesktop
  ];
}
