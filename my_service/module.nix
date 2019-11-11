{ pkgs, ... }:
{
  systemd.services.my_service = {
    serviceConfig.DynamicUser = true;
    script = ''
      ${pkgs.my_service}
    '';
  };
}
