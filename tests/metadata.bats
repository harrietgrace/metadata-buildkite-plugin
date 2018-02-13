#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debug output:
# export WHICH_STUB_DEBUG=/dev/tty

@test "Fetch metadata from build-agent" {
  export BUILDKITE_PLUGIN_METADATA_
  
  
  export BUILDKITE_COMMAND='command1 "a string"'

  stub which \
    "buildkite-agent : echo /buildkite-agent"


