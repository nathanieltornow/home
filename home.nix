{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    ripgrep

    texlive.combined.scheme-full
    qemu

    clang
    clang-tools
    cmake

    protoc-gen-go
    protoc-gen-go-grpc
    protobuf

    nodejs-16_x

    python39
    python39Packages.pylint

    lazygit

    antlr

    nomad
    consul
    vagrant
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Nathaniel Tornow";
    userEmail = "nathaniel.tornow@tum.de";
    extraConfig = {
      github.user = "nathanieltornow";
      pull.rebase = true;
    };
  };

  programs.fzf.enable = true;

  programs.go = {
    enable = true;
    goPath = "go";
    goBin = ".local/bin.go";
  };

  programs.bash = {
    enable = true;
    shellAliases = import ./aliases.nix;
    sessionVariables = rec {
      # DEV_ALLOW_ITERM2_INTEGRATION = "1";
      EDITOR = "vim";
      GIT_EDITOR = EDITOR;
      CLICOLOR = "YES";
      TERM = "xterm-256color";
    };
    initExtra = "bindkey -v";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = import ./aliases.nix;
    sessionVariables = rec {
      # DEV_ALLOW_ITERM2_INTEGRATION = "1";
      EDITOR = "vim";
      GIT_EDITOR = EDITOR;
      CLICOLOR = "YES";
      TERM = "xterm-256color";
    };
    initExtra = "bindkey -v";
  };


  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
    };
  };


  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config.vim;

    coc = {
      enable = true;
      settings = {
        "rust-analyzer.serverPath" = "rust-analyzer";
        "python.analysis.useLibraryCodeForTypes" = false;
      };
    };

    plugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
      # vim-fugitive
      # vim-go
      coc-lists
      coc-nvim
      coc-go
      coc-cmake
      coc-clangd
      coc-pyright
      coc-explorer
      coc-rust-analyzer
      vim-airline

      vimtex
      coc-vimtex

      vim-hcl
      vim-commentary
      telescope-nvim
      vim-surround
      nvim-treesitter
      lazygit-nvim
    ];
  };

}
