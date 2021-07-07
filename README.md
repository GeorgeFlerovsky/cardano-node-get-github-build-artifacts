# Get `cardano-node` and `cardano-cli` binaries from Github
Get `cardano-node` and `cardano-cli` binaries for a specific branch/tag of the `input-output-hk/cardano-node` repository, using the Github API.

## Pre-requisites

This project has been developed/tested on a Linux system, and it requires the [direnv](https://direnv.net/) and [jq](https://stedolan.github.io/jq/) utilities.

In the Setup scripts below, the Github API is used to find and download the correct `cardano-node` binary executables. Unfortunately, the Github API requires a personal access token to actually download the files via the link that it provides. You will need to [get your own token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) (you only need to add the `public repo` scope to the token) and write it to a file called `github-token` in the root project folder.

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
Note that if you want a different branch/tag from the cardano-node repository, or a different OS than linux, then you should modify the variable values at the top of [./script/download-alonzo-blue-executables.sh](./script/download-alonzo-blue-executables.sh). Possible values for OS are: ubuntu, macos, windows.

The script downloads the binary executables by querying the Github API for the build artifacts that were generated for the commit associated with the tag.

Make sure that the executables are properly installed and visible on the system path:
```bash
user@machine$ cardano-cli --version

user@machine$ cardano-node --version
```

## Run the node

Start the `cardano-node` process:
```bash
user@machine$ ./script/start-node.sh
```

This starts a passive node (which does not produce blocks). Instructions for running a stakepool on testnet are currently outside of the scope of this project.

Logging information from the process is written to `db/node.log`, which you can inspect with the tool of your choice. For example, if you install the [lnav](https://lnav.org/) utility, then you view the log file as follows:
```bash
user@machine$ lnav -t -c ':goto 100%' $NODE_HOME/node.log
```

## Query the node

Most CLI commands on the testnet have to use the parameter `--testnet-magic 5`.

Query the latest synchronized block on the local node:
```bash
user@machine$ cardano-cli query tip --testnet-magic 5
```
