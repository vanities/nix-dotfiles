{ pkgs, ... }@inputs: {
  nixpkgs.overlays = [
    (self: super: {
      wldash = super.wldash.override (old: {
        rustPlatform = old.rustPlatform // {
          buildRustPackage = args: old.rustPlatform.buildRustPackage (args // {
            src = super.fetchFromGitHub {
              owner = "cyrinux";
              repo = "wldash";
              rev = "9cc29f2507a746ef6359dd081d9f2fe2f43c2a23";
              hash = "sha256-aATJIHETQDX1UXkn5/1jVESgdQFbTFySYuL01NvP54s=";
            };
            cargoHash = "sha256-Ot+GnnbFFS6e86uhNDoujlX/oQX9Ckp+M467sXJOD60=";
            cargoPatches = [ ];
          });
        };
      });

      # it was never meant to be packaged with --libnotify by default ☹️
      yubikey-touch-detector = super.yubikey-touch-detector.overrideAttrs (old: {
        postInstall = old.postInstall + ''
          substituteInPlace $out/lib/systemd/user/*.service --replace "--libnotify" ""
        '';
      });

      signal-desktop = super.signal-desktop.overrideAttrs (_old:
        let version = "7.19.0"; in {
          inherit version;
          src = super.fetchurl {
            url = "https://github.com/0mniteck/Signal-Desktop-Mobian/raw/${version}/builds/release/signal-desktop_${version}_arm64.deb";
            hash = "sha256-L5Wj1ofMR+QJezd4V6pAhkINLF6y9EB5VNFAIOZE5PU=";
          };
        });
    })
  ];
}
