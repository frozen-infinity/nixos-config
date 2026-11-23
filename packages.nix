{ inputs, pkgs,... }:

{
  environment.systemPackages = with pkgs; [
    # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gh
    wget
    kitty
    hyprland
    quickshell
    tor-browser
    udiskie
    firefox
    jq
    tailscale
    nerd-fonts.jetbrains-mono
    helix
    zsh
    jetbrains.clion
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    nbfc-linux
    nautilus
    bibata-cursors
    starship
    cl-wordle
    clang
    gcc
    chatgpt
    teams-for-linux
    hyprlock
    zip
    unzip
    telegram-desktop
    zoom-us
    spotify
    chafa
    iio-sensor-proxy
    qbittorrent
    wineWow64Packages.stable
    winetricks
    nixfmt
    nixd
    clang-tools
    gdb
    scrcpy
    appimage-run
  ];


}
