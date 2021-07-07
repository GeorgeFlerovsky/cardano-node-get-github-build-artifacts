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

## Manage keys/addresses
WARNING: This is a poor man's wallet management tool, ONLY meant for use on the Alonzo testnet. You have been warned!

A "wallet" is a set of payment keys, staking keys, staking address, and payment address.

Create wallet 1:
```bash
user@machine$ ./script/cardano-wallet create 1
Creating wallet 1 at $NODE_HOME/wallet/1
```

Get the address for wallet 1:
```bash
user@machine$ ./script/cardano-wallet address 1
addrijaoij123aosicamoiaiom

user@machine$ ./script/cardano-wallet 1
addrijaoij123aosicamoiaiom
```

Get the utxo balances for wallet 1:
```bash
user@machine$ ./script/cardano-wallet balance 1

Wallet 1: addrijaoij123aosicamoiaiom

                           TxHash                                 TxIx        Amount
--------------------------------------------------------------------------------------
asdoaijoasd21231231dawsdaoij                                         1        182734 lovelace + TxOutDatumHashNone
ipousacvnsuunqqlkjq123aoimco                                         1        1237896912387619 lovelace + TxOutDatumHashNone
```

Remove wallet 1:
```bash
user@machine$ ./script/cardano-wallet remove 1
Are you sure you want to remove wallet 1 at $NODE_PATH/wallet/1 (y/n)? y
Removing wallet 1
```

## Next steps

Explore the [testnet exercises for the Alonzo testnet](https://github.com/input-output-hk/Alonzo-testnet).

## Troubleshooting and contributing
TODO. Contributions are welcome, particularly for other OS support and more robust error-handling.
