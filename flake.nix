{
  description = "vanities";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    push2talk = {
      url = "github:cyrinux/push2talk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    network-dmenu = {
      url = "github:cyrinux/network-dmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let globals = { user = "vanities"; }; in rec {
      nixosConfigurations = {
        home-manitoba = import ./hosts/home-manitoba { inherit inputs globals; };
      };

      darwinConfigurations = {
        MMDFLQCPF9676 = import ./hosts/MMDFLQCPF9676 { inherit inputs globals; };
      };

      homeConfigurations = {
        home-manitoba = nixosConfigurations.home-manitoba.config.home-manager.users.${globals.user}.home;
        MMDFLQCPF9676 = darwinConfigurations.MMDFLQCPF9676.config.home-manager.users.${globals.user}.home;
      };
    };
}
