{ config, pkgs, ... }:
let
  coq_nvim = pkgs.vimUtils.buildVimPlugin rec {
    name = "coq_nvim";

    src = pkgs.fetchFromGitHub {
      owner = "ms-jpq";
      repo = name;
      rev = "9a2de81f7927690ca09cc0e57d779dda96acdbb9";
      sha256 = "bjJRALK9uK2FXYPexrwQ0pRXXz/ftnM0v9AGy9UefPM=";
    };
  };
  coq-artifacts = pkgs.vimUtils.buildVimPlugin rec {
    name = "coq.artifacts";

    src = pkgs.fetchFromGitHub {
      owner = "ms-jpq";
      repo = name;
      rev = "43029af68798ea4c2f62e2dd87083f8dd7428702";
      sha256 = "KmudRy61F1IT4UF8jZxFGwP2AghFRiKVHFdr+uDLQsc=";
    };
  };
  
in {

  home.packages = with pkgs; [
    texlive.combined.scheme-basic
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
    liberation_ttf
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
      CLICOLOR = "YES";
      TERM = "xterm-256color";
    };
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
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config2.vim;
    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox
      nvim-lspconfig
      coq_nvim
      coq-artifacts
      chadtree
    ];
  };

}
