{
  fetchurl,
  lib,
  virtualbox,
}:
let
  virtualboxExtPackVersion = "7.1.8";
in
fetchurl rec {
  name = "Oracle_VirtualBox_Extension_Pack-${virtualboxExtPackVersion}.vbox-extpack";
  url = "https://download.virtualbox.org/virtualbox/${virtualboxExtPackVersion}/${name}";
  sha256 =
    # Manually sha256sum the extensionPack file, must be hex!
    # Thus do not use `nix-prefetch-url` but instead plain old `sha256sum`.
    # Checksums can also be found at https://www.virtualbox.org/download/hashes/${version}/SHA256SUMS
    let
      value = "912586a3a1e9285f9df264f7999e6fffc0b8a42f2e013dd898a86f7ed3975d37";
    in
    assert (builtins.stringLength value) == 64;
    value;

  meta = with lib; {
    description = "Oracle Extension pack for VirtualBox";
    license = licenses.virtualbox-puel;
    homepage = "https://www.virtualbox.org/";
    maintainers = with maintainers; [
      sander
      friedrichaltheide
    ];
    platforms = [ "x86_64-linux" ];
  };
}
