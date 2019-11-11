{ nixosTest }:
nixosTest {
  nodes.webserver = { pkgs, ... }: {
    systemd.services.my_service = {
      wantedBy = [ "multi-user.target" ];
      script = "${pkgs.my_service}/bin/my_service";
      serviceConfig.DynamicUser = true;
    };
    networking.firewall.allowedTCPPorts = [ 8080 ];
    environment.systemPackages = [ pkgs.curl ];
  };
  nodes.client = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.curl ];
  };
  testScript = ''
    $webserver->start;
    $webserver->waitForOpenPort(8080);
    $webserver->succeed('curl -q localhost:8080');

    $client->start;
    $client->waitForUnit("multi-user.target");
    $client->succeed('curl -v http://webserver:8080');
  '';
}
