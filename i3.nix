{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    
    config = rec {
      modifier = "Mod4";
      bars = [];
      
      window.border = 0;
      
      gaps = {
        inner = 15;
        outer = 5;
      };
      
      keybindings = lib.mkOptionDefault {
        "${modifier}+Scroll_Lock" = "exec brightnessctl set 4%-";
        "${modifier}+Pause" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec ${import ./alacritty-master.nix}/bin/alacritty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";

        "${modifier}+Shift+x" = "exec systemctl suspend";
      };
      
      startup = [
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-fill ~/background_left.jpg --bg-fill ~/background_right.jpg";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
