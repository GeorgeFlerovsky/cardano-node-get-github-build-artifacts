#!/bin/bash

# If this script had a command-line interfact, then these would be parameters.
branch="alonzo-blue2.0"
tag="alonzo-blue2.0"
os="ubuntu"

# Github API requires a personal access token. This is token from a dummy account.
# Github seems to enjoy invalidating this token, so it may need to be replaced
# periodically.
token="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"

bindir=$NODE_HOME/bin

# ====================================================================================
# Find the build artifacts corresponding to a tag in a branch

tmpdir1=$(mktemp -d -t download1-XXXXXXXXXXXXXXXX)
cd $tmpdir1

# Get the commit hash that corresponds to the chosen tag
curl -s -L "https://api.github.com/repos/input-output-hk/cardano-node/tags" --output tags.json
tag_commit=$(jq --arg tag $tag '.[] | select(.name | contains($tag)) | .commit.sha' -cr tags.json)

# From the cardano node repositories' workflows, select the ones that build executables.
# Their IDs were [4656235,2606421] at the time this script was written.
curl -s -L "https://api.github.com/repos/input-output-hk/cardano-node/actions/workflows" --output workflows.json
workflows=$(jq '[.workflows[] | select(.name | contains("Haskell CI")) | .id]' -cr workflows.json)

curl -s -L "https://api.github.com/repos/input-output-hk/cardano-node/actions/runs?event=push&status=success&branch=$branch" --output workflow_runs.json
workflow_run=$(jq --argjson workflows $workflows --arg tag_commit $tag_commit '.workflow_runs[] | select(([.workflow_id] | inside($workflows)) and (.head_commit.id == $tag_commit)) | .id' -cr workflow_runs.json)

curl -s -L "https://api.github.com/repos/input-output-hk/cardano-node/actions/runs/$workflow_run/artifacts" --output artifacts_workflow.json
artifact_url=$(jq --arg os $os '.artifacts[] | select(.name | contains($os) and (contains("chairman") | not)) | .archive_download_url' -cr artifacts_workflow.json)

# ====================================================================================
# Download and extract the build artifacts into the node's bin folder

# Ensure that the `bin` directory exists.
[ -d $bindir ] || mkdir $bindir

tmpdir2=$(mktemp -d -t download2-XXXXXXXXXXXXXXXX)
cd $tmpdir2

# Download the artifacts
curl -L -H "Authorization: token $token" $artifact_url --output $tmpdir1/artifacts.zip

# The downloaded ZIP archive contains individual GZ archives per build file.
unzip $tmpdir1/artifacts.zip

# Extract the binary executables from individual GZ archives into the bin directory.
find . -type f -exec tar -xvf {} -C $bindir \;

# ====================================================================================
# Clean up

cd $bindir

# Remove temporary folders.
rm -rf $tmpdir1 $tmpdir2
