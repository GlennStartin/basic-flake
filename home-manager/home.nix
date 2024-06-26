# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{  inputs,  lib,  config,  pkgs,  ...}:

{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # targets.genericLinux.enable = true; #Enable this on non-NixOS
  # home.packages = with pkgs; [ steam ];
  home = {
    username = "glenn";
    homeDirectory = "/home/glenn";
    packages = with pkgs; [
      pkgs.hello
    ];
  };

  # Add stuff for your user as you see fit:
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''${builtins.readFile ../nvim/init.lua}'';
  };
  programs.git = { 
    enable = true;
    userName = "GlennStartin";
    userEmail = "glenn.startin@gmail.com";
    };

  # Enable home-manager and git
  # disable hyprland until I have a decent stable setup that I know I want
  # programs.home-manager.enable = true;
  #wayland.windowManager.hyprland = {
  #  # allow home-manager to configure hyprland
  #  enable = true;
  #};

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
