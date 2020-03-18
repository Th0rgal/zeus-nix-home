{ config, pkgs, lib, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    aiohttp
    aiohttp-jinja2
    faker
    pywal
    pygame
    pillow
    requests
    (callPackage ./discordpy.nix { })
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  {
    imports = [ ./i3.nix ./polybar.nix ./rofi.nix ];
    nixpkgs.config.allowUnfree = true;

    home.keyboard.layout = "fr";

    home.packages = with pkgs; [
      # TERMINAL
      (import ./alacritty-master.nix) # Till they fix the background_opacity bug
      gotop htop neofetch cava zip unrar unzip xorg.xev escrotum xclip tree
      aria2 imagemagick feh
      # DEVELOPMENT
      gradle idea.idea-ultimate vscodium (callPackage ./termius.nix { })
      nodejs python-with-my-packages zulu8 rustup gcc m4 gnumake binutils
      # OFFICE
      discord vlc typora spotify (callPackage ./wpsoffice.nix { }) tor-browser-bundle-bin
      # FONTS
      powerline-fonts roboto siji (import ./termsyn.nix) source-code-pro dejavu_fonts noto-fonts-emoji
      # GAMES
      bastet multimc minecraft
      # CONNEXION
      (callPackage ./anydesk.nix { })
      tigervnc
    ];

    programs = {
      home-manager.enable = true;
      command-not-found.enable = true;
      firefox.enable = true;

      # alacritty = import ./alacritty.nix { inherit pkgs; };

      git = {
        enable = true;
        userName = "Thomas Marchand";
        userEmail = "thomas.marchand" + "@" + "tuta.io";
      };
    };
    
    services = {
      compton = import ./compton.nix {};
    };

	xsession.enable = true;
  }
