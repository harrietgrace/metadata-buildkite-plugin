#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debug output:
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Fetch single meta-data value from build-agent" {
  export BUILDKITE_PLUGIN_METADATA_GET_0=BUILD_ID

  stub buildkite-agent \
    "meta-data get \"BUILD_ID\" : echo 1234567890"

  run $PWD/hooks/pre-command

  assert_success
  assert_output --partial 1234567890

  unstub buildkite-agent

  unset BUILDKITE_PLUGIN_METADATA_GET_0
}

@test "Fetch multiple meta-data values from build-agent" {
  export BUILDKITE_PLUGIN_METADATA_GET_0=BUILD_ID
  export BUILDKITE_PLUGIN_METADATA_GET_1=APP_ENDPOINT

  stub buildkite-agent \
    "meta-data get \"BUILD_ID\" : echo 1234567890" \
    "meta-data get \"APP_ENDPOINT\" : echo 'http://example.com/foo'"

  run $PWD/hooks/pre-command

  assert_success
  assert_output --partial 1234567890
  assert_output --partial 'http://example.com/foo'

  unstub buildkite-agent

  unset BUILDKITE_PLUGIN_METADATA_GET_0
  unset BUILDKITE_PLUGIN_METADATA_GET_1
}

@test "Fetch meta-data value from another pipeline" {
  export BUILDKITE_PLUGIN_METADATA_GET_0=BUILD_ID
  export BUILDKITE_PLUGIN_METADATA_JOBID=1234567890-abcdef-098765-acedecade

  stub buildkite-agent \
    "meta-data get \"BUILD_ID\" --job 1234567890-abcdef-098765-acedecade : echo 0987654321"

  run $PWD/hooks/pre-command

  assert_success
  assert_output --partial 0987654321

  unstub buildkite-agent

  unset BUILDKITE_PLUGIN_METADATA_JOBID
  unset BUILDKITE_PLUGIN_METADATA_GET_0
}

