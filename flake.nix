{
  description = "SV06 Source Code";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... } @ inputs:
  inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];

    imports = [
      inputs.devshell.flakeModule
    ];

    perSystem = { system, ... }:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
    in
    {
      devshells.default = {
        packages = with pkgs; [
          platformio-core
          #scons
          #openocd
        ];
      };
    };
  };
}

