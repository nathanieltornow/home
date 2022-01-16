{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    packages.x86_64-darwin.homeConfigurations."nathanieltornow" = inputs.home-manager.lib.homeManagerConfiguration {
      system = "x86_64-darwin";
      homeDirectory = "/Users/nathanieltornow";
      username = "nathanieltornow";
      stateVersion = "21.11";
      configuration.imports = [ ./home.nix ];
    };

    packages.x86_64-linux.homeConfigurations."nate" = inputs.home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      homeDirectory = "/home/nate";
      username = "nate";
      stateVersion = "21.11";
      configuration.imports = [ ./home.nix ];
    };
  };
}

