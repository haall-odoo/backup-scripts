# Backup Scripts
This tools allows to make easy backup of `/home/<user>/`.

To recover the backup: simply untar the backup in your home. It will place the backup files at places they belong to.

This repository idea was a suggestion of MBEC to fill my Friday afternoon with some code.

## Features
### Config file
The `backup.conf` file should be located alongside the `backup.sh` script.
It allows to customize most aspect of the archive.
- `ADDITIONAL_PATHS` allows to include other files and directory in the backup
- `EXCLUDED_PATHS` allows to exclude specific path from the archive

⚠️  `EXCLUDED_PATHS` cannot exclude path included by `ADDITIONAL_PATH`

#### Config file example
```sh
# Global configurations
VERSION=0.1.1
NAME=backup-custom
ADDITIONAL_PATHS="~/.ssh/"

EXCLUDED_PATHS="snap"

# Colors
...
```
This configuration will include `/home/<user>/.ssh` and it will exclude `/home/<user>/snap`

```sh
# Global configurations
VERSION=0.1.1
NAME=backup-custom
ADDITIONAL_PATHS="~/.ssh/ ~/.config"

EXCLUDED_PATHS="snap .ssh"

# Colors
...
```
This configuration will include `/home/<user>/.ssh` and also `/home/<user>/.config` and only exclude `/home/<user>/snap`

To be sure of what will be included using your configuration you can check it with the following command:
```sh
./backup.sh info
```

### Modes
- **info**: Display all the configuration and included paths
- **run**: Build the archive in the `/tmp/backup-<serialnumber>_<date>_<hour:min:sec>.tar.zst`