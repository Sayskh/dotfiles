{...}: {
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.mangowc = {};

  security.sudo.extraRules = [
    {
      users = ["hio"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}

