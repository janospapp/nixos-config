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
    rev = "98356dbb55c2a9d9c28e0339bb7e7dd441147a5a";
    hash = "sha256-1ajIO2O1LwRcbWy+iKf+qj3EC30I6jkDDzVlEQeFH6s=";
  };

  installPhase = ''
    runHook preInstall

    TEMPLATE_DIR=$out/share/plasma/layout-templates

    mkdir -p $TEMPLATE_DIR
    cp -r ./topbarPanel $TEMPLATE_DIR

    runHook postInstall
  '';
}
