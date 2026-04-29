{ pkgs, hwsuhdx1, ... }:

let
  switchCapture = pkgs.writeShellScriptBin "switch-capture" ''
    set -e

    # 1. Kill any existing loopbacks
    pkill -9 pw-loopback || true

    # 2. Get AVMatrix Device ID
    DEV_ID=$(${pkgs.wireplumber}/bin/wpctl status | grep "AVMatrix" | head -n 1 | sed 's/[^0-9]*\([0-9]\+\).*/\1/')
    
    # 3. Force Pro-Audio Profile
    ${pkgs.wireplumber}/bin/wpctl set-profile "$DEV_ID" pro-audio || true
    sleep 1

    # 4. Find the Input Node (The actual pins on the card)
    # We look for 'pro-input' specifically
    AUDIO_SRC=$(${pkgs.pipewire}/bin/pw-cli ls Node | ${pkgs.gawk}/bin/gawk '/node.name = ".*AVMatrix.*pro-input.*"/ { match($0, /"([^"]+)"/, a); print a[1]; exit }')

    # 5. Find the iFi DAC Output Node
    # Using the name from your pw-top output
    AUDIO_SINK="alsa_output.usb-iFi__by_AMR__iFi__by_AMR__HD_USB_Audio_0003-00.analog-stereo"

    # 6. Unmute the Hardware
    ${pkgs.wireplumber}/bin/wpctl set-mute "$AUDIO_SRC" 0 || true
    ${pkgs.wireplumber}/bin/wpctl set-volume "$AUDIO_SRC" 1.0 || true

    # 7. Start Loopback with "Direct" properties 
    # This ignores EasyEffects and system defaults
    echo "Direct Link: $AUDIO_SRC -> $AUDIO_SINK"
    PIPEWIRE_LATENCY="512/48000" ${pkgs.pipewire}/bin/pw-loopback \
      --name="switch-audio" \
      --capture-props="node.target=\"$AUDIO_SRC\", stream.capture.sink=true, node.passive=true" \
      --playback-props="node.target=\"$AUDIO_SINK\", node.passive=true" &

    # 8. Launch MPV
    ${pkgs.mpv}/bin/mpv av://v4l2:/dev/video0 \
        --profile=low-latency --untimed --video-sync=audio --framedrop=vo \
        --no-cache --vd-lavc-threads=4 \
        --demuxer-lavf-o=video_size=3840x2160,framerate=60,input_format=yuyv422,low_latency=1,buffers=8 \
        --vo=gpu-next --gpu-api=vulkan --hwdec=no --no-audio \
        --title="Nintendo Switch - 4K60"
  '';
  
  switchDesktop = pkgs.makeDesktopItem {
    name = "switch-capture";
    desktopName = "Nintendo Switch Capture";
    exec = "${switchCapture}/bin/switch-capture";
    icon = "multimedia-video-player";
    terminal = false;
    categories = [ "Game" "AudioVideo" ];
  };

in
{
  imports = [ hwsuhdx1.nixosModules.hwsuhdx1 ];
  hardware.hwsuhdx1.enable = true;

  boot.kernelParams = [ 
    "pcie_aspm=off" 
    "usbcore.autosuspend=-1" 
    "preempt=full"
    "nvme_core.default_ps_max_latency_us=5500"
  ];

  security.pam.loginLimits = [
    { domain = "luca"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "luca"; item = "memlock"; type = "-"; value = "unlimited"; }
  ];

  services.pipewire.extraConfig.pipewire."99-clock-fix" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 512;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 1024;
    };
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    mpv
    v4l-utils
    switchCapture
    switchDesktop
    pipewire
    wireplumber
    gawk
  ];
}