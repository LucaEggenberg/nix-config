{ config, lib, pkgs, ... }: 
let
    cfg = config.hyprland.custom;
in {
    config = {
        home.packages = with pkgs; [
            grim
            grimblast
            slurp
            swww
        ];

        wayland.windowManager.hyprland =  {
            enable = true;

            settings = {
                monitor = cfg.monitors;
                input = lib.mkMerge [
                    {
                        follow_mouse = 1;
                        float_switch_override_focus = 0;
                        numlock_by_default = true;
                        force_no_accel = false;

                        touchpad.natural_scroll = true;
                        sensitivity = 0.5;
                    }
                    cfg.inputs
                ];

                xwayland.force_zero_scaling = true;

                exec-once = [
                    "waybar"
                    "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh"
                    "blueman-applet"
                    "wl-paste -t text --watch cliphist store"
                    "swww-daemon"
                    "hypridle"
                ] ++ cfg.autostarts;

                env = [
                    "GTK_THEME,Adwaita-dark"
                    "ELECTRON_OZONE_PLATFORM_HINT, auto"
                    "HYPRCURSOR_SIZE, 24"
                    "XCURSOR_SIZE, 24"
                ];

                general = {
                    gaps_in = 5;
                    gaps_out = 10;
                    border_size = 2;

                    "col.active_border" = "rgb(ca9ee6)";
                    "col.inactive_border" = "rgb(3b4252)";
                    
                    layout = "dwindle";
                };

                decoration = {
                    rounding = 10;
                    blur = {
                        enabled = true;
                        size = 3;
                        passes = 1;
                        vibrancy = 0.16;
                    };

                    active_opacity = 1.0;
                    inactive_opacity = 0.9;
                };

                animations = {
                    enabled = true;
                    bezier = [
                        "myBezier, 0.05, 0.9, 0.1, 1.05"
                        "easeOutExpo, 0.16, 1, 0.3, 1"
                    ];
                    animation = [
                        "windows, 1, 7, myBezier, slide"
                        "fade, 1, 7, easeOutExpo"
                        "workspaces, 1, 6, default, slide"
                    ];
                };

                dwindle = {
                    pseudotile = true;
                    force_split = 2;
                };

                gestures.workspace_swipe = true;

                windowrule = [
                    "float,class:^(wofi)$"
                    "size 800 600,class:^(wofi)$"
                    "center,class:^(wofi)$"
                    "idleinhibit focus, class:^(mpv)"
                ];
            };

            extraConfig = ''
                $cmd = ALT
                $win = SUPER

                binds {
                    scroll_event_delay = 0
                }

                # Terminal
                bind = $cmd,        RETURN, exec, kitty
                bind = $cmd SHIFT,  RETURN, exec, [float] kitty

                # Hyprland
                bind = $cmd SHIFT,  P,      exec, wlogout
                bind = $cmd,        SPACE,  exec, wofi --show drun
                bind = $cmd,        S,      swapnext

                bind = $cmd,        Q,      killactive,
                bind = $cmd SHIFT,  Q,      exec, kill -9 $(hyprctl activewindow | grep pid | tail -1 | awk '{print$2}')

                bind = $cmd,        W,      togglefloating,
                bind = $cmd,        W,      centerwindow
                bind = $cmd SHIFT,  W,      exec, hyprctl dispatch workspaceopt allfloat
                bind = $cmd,        F,      fullscreen

                bind = $cmd,        E,      pseudo
                bind = $cmd SHIFT,  E,      exec, hyprctl dispatch workspaceopt allpseudo

                # Misc
                bind = $win,        L,      exec, hyprlock
                bind = $win,        E,      exec, [float] nautilus --new-window
                bind = $win SHIFT,  M,      exec, ~/.config/hypr/scripts/wallpapers.sh
                bind = $win, 	    F12,    exec, hyprctl dispatch dpms off
                bind = $win SHIFT,  F12,    exec, hyprctl dispatch dpms on

                bind = $win,        mouse_up, exec, pamixer -d 1
                bind = $win,        mouse_down, exec, pamixer -i 1

                # Navigate workspace
                bind = $cmd, H, movefocus, l
                bind = $cmd, L, movefocus, r
                bind = $cmd, K, movefocus, u
                bind = $cmd, J, movefocus, d

                # Move active window
                bind = $cmd SHIFT, H, movewindow, l
                bind = $cmd SHIFT, L, movewindow, r
                bind = $cmd SHIFT, K, movewindow, u
                bind = $cmd SHIFT, J, movewindow, d

                bindm = $cmd, mouse:272, movewindow

                # Resize
                bindm = $cmd, mouse:273, resizewindow

                bind = $cmd SHIFT, R, submap, resize
                submap = resize
                bind = , L, resizeactive, 30 0
                bind = , H, resizeactive, -30 0
                bind = , K, resizeactive, 0 -30
                bind = , J, resizeactive, 0 30
                bind = , escape, submap, reset
                submap = reset


                # Open workspace 0-9
                bind = $cmd, 1, workspace, 1
                bind = $cmd, 2, workspace, 2
                bind = $cmd, 3, workspace, 3
                bind = $cmd, 4, workspace, 4
                bind = $cmd, 5, workspace, 5
                bind = $cmd, 6, workspace, 6
                bind = $cmd, 7, workspace, 7
                bind = $cmd, 8, workspace, 8
                bind = $cmd, 9, workspace, 9
                bind = $cmd, 0, workspace, 10

                # Move active to workspace 0-9
                bind = $cmd SHIFT, 1, movetoworkspace, 1
                bind = $cmd SHIFT, 2, movetoworkspace, 2
                bind = $cmd SHIFT, 3, movetoworkspace, 3
                bind = $cmd SHIFT, 4, movetoworkspace, 4
                bind = $cmd SHIFT, 5, movetoworkspace, 5
                bind = $cmd SHIFT, 6, movetoworkspace, 6
                bind = $cmd SHIFT, 7, movetoworkspace, 7
                bind = $cmd SHIFT, 8, movetoworkspace, 8
                bind = $cmd SHIFT, 9, movetoworkspace, 9
                bind = $cmd SHIFT, 0, movetoworkspace, 10

                # SYSTEM/MEDIA CONTROLS
                bind = , Print, exec, grimblast copy screen
                bind = $win, Print, exec, grimblast copy area

                bind = , XF86AudioRaiseVolume, exec, pamixer -i 5  # Volume Up
                bind = , XF86AudioLowerVolume, exec, pamixer -d 5  # Volume Down
                bind = , XF86AudioMute, exec, pamixer -t          # Volume Mute (toggle)

                bind = , XF86MonBrightnessUp, exec, light -A 5     # Brightness Up
                bind = , XF86MonBrightnessDown, exec, light -U 5   # Brightness Down

                # [DEBUG] Reload waybar
                bind = $win SHIFT, W, exec, pkill -9 waybar && hyprctl dispatch exec waybar
            '';
        };

        home.file = {
            ".config/hypr/frappe.conf".source = ./assets/hypr/frappe.conf;
            ".config/hypr/hyprlock.conf".source = ./assets/hypr/hyprlock.conf;
            ".config/hypr/scripts/wallpapers.sh".source = ./assets/hypr/scripts/wallpapers.sh;
        };
    };

    options.hyprland.custom = {
        monitors = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ 
                "monitor=,preferred,auto,1"
                "monitor=,highrr,auto,1"
                "monitor=,highres,auto,1" 
            ];
            description = "Hyprland monitor configuration";
        };
        autostarts = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Commands to execute once at the start of the session";
        };
        inputs = lib.mkOption {
            type = lib.types.attrs;
            default = { 
                kb_layout = "ch";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";
            };
            description = "Hyprland input configuration";
        };
    };
}