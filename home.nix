{ ... }: {
  home.stateVersion = "26.05";

  xdg.configFile."kitty/".source = ./configs/kitty;

  xdg.configFile."hypr/".source = ./configs/hypr;

  xdg.configFile."Brain_Shell/".source = ./configs/Brain_Shell;

  xdg.configFile."helix/".source = ./configs/helix;

  xdg.configFile."quickshell/".source = ./configs/quickshell;

  xdg.configFile."starship.toml".source = ./configs/starship.toml;

  home.file.".zshrc".source = configs/.zshrc;
  home.file.".local/bin/appdeck".source = configs/appdeck;
  
  home.file."Wallpapers/".source = ./Desktop-wallpapers;
}
