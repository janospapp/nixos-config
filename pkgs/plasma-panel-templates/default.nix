{
  stdenvNoCC,
  fetchFromGitHub
}:
stdenvNoCC.mkDerivation {
  pname = "plasma-panel-templates";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "janospapp";
    repo = "plasma-panel-templates";
    rev = "51ef5e0be270d76d7a66d74d99ecfe5e54cd32ac";
    hash = "sha256-VMG+zuoq44cYYraeL4TVHWLfOjKk1Be3/7Mm40cB5So=";
  };

  installPhase = ''
    runHook preInstall

    TEMPLATE_DIR=$out/share/plasma/layout-templates

    mkdir -p $TEMPLATE_DIR
    cp -r ./topbarPanel $TEMPLATE_DIR
    mv $TEMPLATE_DIR/topbarPanel $TEMPLATE_DIR/org.kde.plasma.desktop.janospapp.topbarPanel
    chmod +x -R $TEMPLATE_DIR

    runHook postInstall
  '';
}
