# aqua-test

## Usage

### Docker

#### Start

```bash
docker compose up -d
docker compose exec work bash
```

#### Stop

```bash
docker compose down
```

#### Build

```bash
docker compose build
```

## Samples

### 01_install

```bash
$ cd ~/work/01_install/

# Confirm there is no gh command.
$ gh --version
bash: gh: command not found

# Install gh by aqua.
$ aqua i
INFO[0000] download and unarchive the package            aqua_version=1.36.0 env=linux/amd64 package_name=aqua-proxy package_version=v1.1.4 program=aqua registry=
INFO[0001] create a symbolic link                        aqua_version=1.36.0 command=aqua-proxy env=linux/amd64 package_name=aqua-proxy package_version=v1.1.4 program=aqua registry=
INFO[0001] create a symbolic link                        aqua_version=1.36.0 command=gh env=linux/amd64 program=aqua
INFO[0001] download and unarchive the package            aqua_version=1.36.0 env=linux/amd64 package_name=cli/cli package_version=v2.24.3 program=aqua registry=standard

# Confirm gh command is installed.
$ gh --version
gh version 2.24.3 (2023-03-09)
https://github.com/cli/cli/releases/tag/v2.24.3
```

### 02_lazy_install

```bash
$ cd ~/work/02_lazy_install/

# Create only symbolic links.
$ aqua i -l
INFO[0000] create a symbolic link                        aqua_version=1.36.0 command=fzf env=linux/amd64 program=aqua

# Execute fzf command and it will be downloaded.
$ fzf --version
INFO[0000] download and unarchive the package            aqua_version=1.36.0 env=linux/amd64 exe_name=fzf package=junegunn/fzf package_name=junegunn/fzf package_version=0.38.0 program=aqua registry=standard
0.38.0 (352ea07)
```

### 03_use_different_version_per_dir

```bash
# If the version of tfenv is set to 2.2.2 in aqua,
# the output will be "tfenv 2.2.2".
$ cd ~/work/03_use_different_version_per_dir/tfenv_2_2_2/
$ aqua i
INFO[0000] create a symbolic link                        aqua_version=1.36.0 command=tfenv env=linux/amd64 program=aqua
INFO[0000] create a symbolic link                        aqua_version=1.36.0 command=terraform env=linux/amd64 program=aqua
INFO[0000] download and unarchive the package            aqua_version=1.36.0 env=linux/amd64 package_name=tfutils/tfenv package_version=v2.2.2 program=aqua registry=standard
$ tfenv --version
tfenv 2.2.2

# If the version of tfenv is set to 2.2.3 in aqua,
# the output will be "tfenv 2.2.3".
$ cd ~/work/03_use_different_version_per_dir/tfenv_2_2_3/
$ aqua i
INFO[0000] download and unarchive the package            aqua_version=1.36.0 env=linux/amd64 package_name=tfutils/tfenv package_version=v2.2.3 program=aqua registry=standard
$ tfenv --version
tfenv 2.2.3

# If tfenv is not managed by aqua,
# the output will be "tfenv 3.0.0",
# confirming you are using a global installation.
$ cd ~/work/03_use_different_version_per_dir/tfenv_3_0_0/
$ tfenv --version
tfenv 3.0.0

# If tfenv is not managed by aqua even in the parent directory,
# the output will be "tfenv 3.0.0",
# confirming you are using a global installation.
$ cd ~/work/03_use_different_version_per_dir/
$ tfenv --version
tfenv 3.0.0
```

### 04_search_and_add

```bash
$ cd ~/work/04_search_and_add/

# Create a configuration file.
$ aqua init

# Confirm a created configuration file.
$ cat aqua.yaml
---
# aqua - Declarative CLI Version Manager
# https://aquaproj.github.io/
# checksum:
#   # https://aquaproj.github.io/docs/reference/checksum/
#   enabled: true
#   require_checksum: true
#   supported_envs:
#   - all
registries:
- type: standard
  ref: v3.145.0 # renovate: depName=aquaproj/aqua-registry
packages:

# Search packages interactively.
# Type "tfmigrate" and press the Enter key.
$ aqua g
- name: minamijoyo/tfmigrate@v0.3.11

# Confirm no packages have been added to a configuration file.
$ cat aqua.yaml
---
# aqua - Declarative CLI Version Manager
# https://aquaproj.github.io/
# checksum:
#   # https://aquaproj.github.io/docs/reference/checksum/
#   enabled: true
#   require_checksum: true
#   supported_envs:
#   - all
registries:
- type: standard
  ref: v3.145.0 # renovate: depName=aquaproj/aqua-registry
packages:

# Confirm searching by package name only results in an error.
$ aqua g tfmigrate
FATA[0000] aqua failed                                   aqua_version=1.36.0 env=linux/amd64 error="unknown package" package_name="standard,tfmigrate" program=aqua

# Confirm searching by registry name and package name returns successful results.
$ aqua g minamijoyo/tfmigrate
- name: minamijoyo/tfmigrate@v0.3.11

# But confirm no packages have been added to a configuration file yet.
$ cat aqua.yaml
---
# aqua - Declarative CLI Version Manager
# https://aquaproj.github.io/
# checksum:
#   # https://aquaproj.github.io/docs/reference/checksum/
#   enabled: true
#   require_checksum: true
#   supported_envs:
#   - all
registries:
- type: standard
  ref: v3.145.0 # renovate: depName=aquaproj/aqua-registry
packages:

# Searching with "i" option will be added to a configuration file.
$ aqua g -i minamijoyo/tfmigrate
$ cat aqua.yaml
---
# aqua - Declarative CLI Version Manager
# https://aquaproj.github.io/
# checksum:
#   # https://aquaproj.github.io/docs/reference/checksum/
#   enabled: true
#   require_checksum: true
#   supported_envs:
#   - all
registries:
- type: standard
  ref: v3.145.0 # renovate: depName=aquaproj/aqua-registry
packages:
- name: minamijoyo/tfmigrate@v0.3.11

# Install tfmigrate by aqua.
$ aqua i
INFO[0000] create a symbolic link                        aqua_version=1.36.0 command=tfmigrate env=linux/amd64 program=aqua
INFO[0000] download and unarchive the package            aqua_version=1.36.0 env=linux/amd64 package_name=minamijoyo/tfmigrate package_version=v0.3.11 program=aqua registry=standard

# Confirm tfmigrate command is installed.
$ tfmigrate --version
0.3.11
```
