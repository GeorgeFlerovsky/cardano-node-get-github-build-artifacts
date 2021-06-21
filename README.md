# cardano-alonzo-blue-starter
Get started quickly with Cardano's Alonzo Blue testnet.

## Pre-requisites

This project has been developed/tested on a Linux system, and it requires the [direnv](https://direnv.net/) and [jq](https://stedolan.github.io/jq/) utilities.

## Setup

Clone this repository, enter the repository's directory. Enable the `direnv` environment for the directory.
```bash
user@machine$ direnv allow
```

Download the `alonzo-blue` configuration files:
```bash
user@machine$ ./script/download-alonzo-blue-configs.sh
```

Download the executable binaries corresponding to the [`alonzo-blue2.0`](https://github.com/input-output-hk/cardano-node/tree/alonzo-blue2.0) tag of the [`input-output-hk/cardano-node`](https://github.com/input-output-hk/cardano-node) repository:
```bash
user@machine$ ./script/download-alonzo-blue-executables.sh 
```

The script downloads the binary executables by querying the Github API for the build artifacts associated with the commit associated with the tag. Unfortunately, Github API requires a personal access token to actually download the files via the link it provides. There is a dummy token (with only `public-repo` scope) hard-coded in the script, but Github may invalidate it at some point if it is overused. You may need to [get your own token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) and overwrite the `token` variable at the top of the `script/download-alonzo-blue-executables.sh` script.


Make sure that the executables are properly installed and visible on the system path:
```bash
user@machine$ cardano-cli --version

user@machine$ cardano-node --version
```

## Next steps

Explore the [testnet exercises for the Alonzo testnet](https://github.com/input-output-hk/Alonzo-testnet).

## Troubleshooting and contributing
TODO. Contributions are welcome, particularly for other OS support and more robust error-handling.
