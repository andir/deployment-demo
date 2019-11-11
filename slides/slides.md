# Nix: Development and Deployment

## From code to production

----

# Roadmap

- Create development environments
- Build code
- Run local docker-compose like test environment
- Run (integration) tests
- Deploy to a NixOS server
- (Deploy to any server)

---

# Create devlopment environments

- direnv
- Niv: Manage Nix dependency pinning (e.g. 3rd party projects, nixpkgs, …)
- Crate2Nix: Convert Cargo.lock files to nix expressions
- Arion: Docker compose style local test containers

---

# direnv

https://direnv.net

```
$ cd project
direnv: loading .envrc
direnv: export +AR +AS +CC +CONFIG_SHELL +CXX +HOST_PATH +IN_NIX_SHELL +LD +NIX_BINTOOLS +NIX_BINTOOLS_WRAPPER_x86_64_unknown_linux_gnu_TARGET_HOST +NIX_BUILD_CORES +NIX_BUILD_TOP +NIX_CC +NIX_CC_WRAPPER_x86_64_unknown_linux_gnu_TARGET_HOST +NIX_ENFORCE_NO_NATIVE +NIX_HARDENING_ENABLE +NIX_INDENT_MAKE +NIX_LDFLAGS +NIX_STORE +NM +OBJCOPY +OBJDUMP +RANLIB +READELF +SIZE +SOURCE_DATE_EPOCH +STRINGS +STRIP +TEMP +TEMPDIR +TMP +TMPDIR +buildInputs +builder +configureFlags +depsBuildBuild +depsBuildBuildPropagated +depsBuildTarget +depsBuildTargetPropagated +depsHostHost +depsHostHostPropagated +depsTargetTarget +depsTargetTargetPropagated +doCheck +doInstallCheck +name +nativeBuildInputs +nobuildPhase +out +outputs +patches +phases +propagatedBuildInputs +propagatedNativeBuildInputs +shell +shellHook +stdenv +strictDeps +system ~PATH
$ my_tool

```

---

# Niv

https://github.com/nmattia/niv

```bash
$ niv init
$ niv show
$ niv update <name>
$ niv modify <name> -b <branch>
$ niv add <user>/<repo>
```

# Crate2Nix

https://github.com/kolloch/crate2nix

```bash

$ crate2nix generate
$ nix-build Cargo.toml -A rootCrate

```



