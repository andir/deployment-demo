{ nixosTest }:
nixosTest {
  nodes.webserver = { pkgs, ... }: {
    systemd.services.my_service = {
      wantedBy = [ "multi-user.target" ];
      script = "${pkgs.my_service}/bin/my_service";
      serviceConfig.DynamicUser = true;
    };
    networking.firewall.allowedTCPPorts = [ 8080 ];
  };
  nodes.client = { pkgs, ... }: {
    services.xserver = {
      enable = true;
      displayManager.auto.enable = true;
      windowManager.default = "icewm";
      windowManager.icewm.enable = true;
      desktopManager.default = "none";
    };

    environment.systemPackages = [ pkgs.firefox pkgs.xdotool ];
  };
  testScript = ''
    $webserver->start;
    $webserver->waitForOpenPort(8080);
    $webserver->succeed('curl -q localhost:8080');

    $client->start;
    $client->waitForX;
    $client->execute("xterm -e 'firefox http://webserver:8080' &");
    $client->waitForWindow("RevealJS");
    $client->sleep(5);

    $client->execute("xdotool key space");

    $client->sleep(2);
    $client->screenshot("screen");
  '';
}
