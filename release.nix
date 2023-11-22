{ self ? import ./.
, supportedSystems ? ["x86_64-linux" "x86_64-darwin"] # "aarch64-darwin"
}:
let
  native-reflex-platform = (self {}).reflex;
  inherit (native-reflex-platform.nixpkgs) lib;

  perPlatform = lib.genAttrs supportedSystems (system: lib.recurseIntoAttrs {
    inherit (self { inherit system; }) exe;
  });
in lib.recurseIntoAttrs perPlatform
