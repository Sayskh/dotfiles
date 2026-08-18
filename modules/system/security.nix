{vars, ...}: {
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.mangowc = {};

  security.sudo.extraRules = [
    {
      users = [vars.username];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
