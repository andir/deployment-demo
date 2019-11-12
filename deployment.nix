{ writeScript
, writeText
, runCommand
, lib
, my_service
, stdenv
, buildEnv
, openssh
, nix
, targets ? []
}:
assert builtins.length targets > 0;
let
  systemdUnit = writeText "my_service.service" ''
    [Unit]
    Description="My awesome service"

    [Install]
    Alias=my_service

    [Service]
    ExecStart=${my_service}/bin/my_service
  '';

  activationScript = writeScript "activate" ''
    #!${stdenv.shell}
    set -ex
    mkdir -p ~/.config/systemd/user/
    rm -f ~/.config/systemd/user/my_service.service
    cp -v ${systemdUnit} ~/.config/systemd/user/my_service.service
    systemctl --user daemon-reload
    systemctl --user stop my_service || true
    systemctl --user start my_service
    systemctl --user status my_service
  '';

  artifact = runCommand "artifact" {} ''
    mkdir -p $out/systemd
    ln -s ${systemdUnit} $out/systemd/.
    ln -s ${activationScript} $out/activate
  '';

in writeScript "deploy.sh" ''
  #!${stdenv.shell}
  PATH=${buildEnv {
    name = "deploment-tools";
    paths = [ openssh nix ];
  }}/bin

  ${lib.concatMapStringsSep "\n" (target: ''
    echo Copying ${artifact} to ${target}
    nix copy --to ssh://${target} ${artifact}
  '') targets}
  ${lib.concatMapStringsSep "\n" (target: ''
    echo activating ${artifact} to ${target}
    ssh ${target} '${artifact}/activate'
    echo switching 'deployment' profile to new generation
    ssh ${target} 'nix-env -p /nix/var/nix/profiles/per-user/$USER/deployment --set ${artifact}'
  '') targets}

''
