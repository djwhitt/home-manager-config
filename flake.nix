{
  description = "Home Manager configuration of djwhitt";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #atuin = {
    #  url = "github:atuinsh/atuin?ref=v17.2.1";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    llama-cpp = {
      url = "github:ggerganov/llama.cpp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, llama-cpp, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [
          (llama-cpp.overlays.default)
          #_(atuin.overlays.default) 
        ];
        inherit system;
        config.allowUnfree = true;
      };
    in rec {
      homeConfigurations."djwhitt" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
