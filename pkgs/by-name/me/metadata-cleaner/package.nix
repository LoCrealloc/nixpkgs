{
  lib,
  python3,
  fetchFromGitLab,
  appstream,
  desktop-file-utils,
  glib,
  gobject-introspection,
  gtk4,
  itstool,
  libadwaita,
  librsvg,
  meson,
  ninja,
  nix-update-script,
  pkg-config,
  poppler_gi,
  wrapGAppsHook4,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "metadata-cleaner";
  version = "2.5.6";
  pyproject = false;

  src = fetchFromGitLab {
    owner = "rmnvgr";
    repo = "metadata-cleaner";
    tag = "v${version}";
    hash = "sha256-J+nwgLbAFoh1gq3J4cqQEShZJCSZesyCjT9DfkCWIHs=";
  };

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    glib # glib-compile-resources
    gtk4 # gtk4-update-icon-cache
    gobject-introspection
    itstool
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
    librsvg
    poppler_gi
  ];

  dependencies = with python3.pkgs; [
    mat2
    pygobject3
  ];

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Python GTK application to view and clean metadata in files, using mat2";
    mainProgram = "metadata-cleaner";
    homepage = "https://gitlab.com/rmnvgr/metadata-cleaner";
    changelog = "https://gitlab.com/rmnvgr/metadata-cleaner/-/blob/v${version}/CHANGELOG.md";
    license = with lib.licenses; [
      gpl3Plus
      cc-by-sa-40
    ];
    maintainers = with lib.maintainers; [ dotlambda ];
  };
}
