{ pkgs, hwsuhdx1, ... }:
let
  switchCapture = pkgs.writeShellScriptBin "switch-capture" ''
    set -euo pipefail

    # Cleanup
    pkill -f "pw-loopback.*switch-capture-audio" || true

    # Hardware: 4K60 NV12
    ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 \
      --set-fmt-video=width=3840,height=2160,pixelformat=NV12 \
      --set-parm=60 || true

    # Audio Loopback (Safety Buffer)
    ${pkgs.pipewire}/bin/pw-loopback \
      -n "switch-capture-audio" \
      -C "alsa_input.pci-0000_04_00.0.stereo-fallback" \
      -P "switch_safety_buffer" \
      --latency=0.04 \
      --capture-props='{ "node.passive": true, "node.driver": false, "node.always-process": true }' &

    LOOPBACK_PID=$!
    trap 'kill $LOOPBACK_PID' EXIT

    # Launch MPV
    exec ${pkgs.mpv}/bin/mpv \
      --profile=low-latency \
      --untimed \
      --no-audio \
      --cache=no \
      --stream-buffer-size=4k \
      --vd-lavc-threads=1 \
      --video-sync=audio \
      --video-latency-hacks=yes \
      --demuxer-lavf-o=video_size=3840x2160,input_format=nv12,framerate=60 \
      --fs \
      av://v4l2:/dev/video0
  '';

  switchDesktop = pkgs.makeDesktopItem {
    name = "switch-capture";
    desktopName = "Nintendo Switch Capture";
    exec = "${switchCapture}/bin/switch-capture";
    terminal = false;
    categories = [ "Game" "AudioVideo" ];
  };
in
{
  imports = [ hwsuhdx1.nixosModules.hwsuhdx1 ];
  hardware.hwsuhdx1.enable = true;

  environment.systemPackages = with pkgs; [
    pipewire mpv v4l-utils switchCapture switchDesktop
  ];

  # Virtual Safety Buffer
  services.pipewire.extraConfig.pipewire."99-switch-buffer" = {
    "context.modules" = [
      {
        name = "libpipewire-module-loopback";
        args = {
          "node.name" = "switch_safety_buffer";
          "node.description" = "Switch Safety Buffer";
          "capture.props" = { 
            "media.class" = "Audio/Sink"; 
            "node.passive" = true;
          };
          "playback.props" = { 
            "node.name" = "switch_safety_output"; 
            "target.object" = "easyeffects_sink"; 
            "node.passive" = true;
          };
        };
      }
    ];
  };

  # Lower capture-card priority & sync with system-clock
  services.pipewire.wireplumber.extraConfig."99-capture-card-priority" = {
    "monitor.alsa.rules" = [
      {
        matches = [ { "node.name" = "~alsa_input.pci-0000_04_00.0.*"; } ];
        actions = {
          update-props = {
            "priority.driver" = 1;
            "priority.session" = 1;
            "node.passive" = true;
            "node.driver" = false;
            "clock.boundary" = 2048;
            "node.force-rate" = 48000;
            "node.force-quantum" = 1024;
          };
        };
      }
    ];
  };
}