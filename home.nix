{ config, pkgs, ... }:

{



  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";


  home.packages = with pkgs; [
    texlive.combined.scheme-basic
    qemu
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.git = {
    enable = true;
    userName = "Nathaniel Tornow";
    userEmail = "nathaniel.tornow@tum.de";
    extraConfig = {
      hub.protocol = "https";
      github.user = "nathanieltornow";
      color.ui = true;
      pull.rebase = true;
      core.commitGraph = true;
      gc.writeCommitGraph = true;
    };
  };

  programs.go = {
    enable = true;
    goPath = "go";
    goBin = ".local/bin.go";
  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = import ./aliases.nix;
    sessionVariables = rec {
      DEV_ALLOW_ITERM2_INTEGRATION = "1";
      EDITOR = "vim";
      GIT_EDITOR = EDITOR;
    };
  };


  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };
  };


  programs.tmux = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config.vim;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      nerdtree
      gruvbox
      vim-fugitive
    ];
  };
}
