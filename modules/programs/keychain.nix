{
  user.homePrograms.keychain = {
    enable = true;
    keys = [
      "id_ed25519"
      "id_ed25519_personal"
      "id_ed25519_work"
    ];
    extraFlags = [
      "--ignore-missing"
      "--quiet"
    ];
  };
}

