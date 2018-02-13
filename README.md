# Meta-data Buildkite plugin

Fetch metadata from the build-kite agent and set it in the environment. Data needs to be set up in a previous step in the current pipeline unless you're providing the 'job' key

## Example

The following example gets the `APP_ENDPOINT` meta-data value from the current pipeline and sets it to `APP_ENDPOINT` in the buildkite agent environment 

```yaml
steps: 
  - command: ./scripts/build.sh
    plugins:
      metadata#v0.0.1:
        get:
          - APP_ENDPOINT
```

The following example gets `BUILD_ID` from the a triggering build ,which pass through it's `BUILDKITE_JOB_ID` as `SOURCE_JOB_ID`, and sets it to `BUILD_ID` on the buildkite agent environment. The job id needs to be passed in to the current pipeline. 

```yaml
steps: 
  - command: ./scripts/build.sh
    plugins:
      metadata#v0.0.1:
        get:
          job: ${SOURCE_JOB_ID}
            - BUILD_ID
```
