# irexchange/metadata Buildkite plugin

Fetch metadata from the build-kite agent and set it in the environment. Data needs to be set up in a previous step in the current pipeline unless you're providing the 'job' key

## Example

The following example gets the `APP_ENDPOINT` meta-data value from the current pipeline and sets it to `APP_ENDPOINT` in the buildkite agent environment 

```yaml
steps: 
  - command: ./scripts/build.sh
    plugins:
      - metadata#v0.0.1:
          get:
            - APP_ENDPOINT
```

The following example gets `VERSION_NUMBER` from the a triggering build ,which pass through it's `BUILDKITE_JOB_ID` as `SOURCE_JOB_ID`, and sets it to `VERSION_NUMBER` on the buildkite agent environment. The job id needs to be passed in to the current pipeline. 

```yaml
steps: 
  - command: ./scripts/build.sh
    plugins:
      - metadata#v0.0.1:
          remoteJobid: ${SOURCE_JOB_ID}
          getRemote:
            - VERSION_NUMBER
```

The following example gets `VERSION_NUMBER` from another pipeline, and `BUILD_ID` from the current pipeline

```yaml
steps: 
  - command: ./scripts/build.sh
    plugins:
      - metadata#v0.0.1:
          remoteJobid: ${SOURCE_JOB_ID}
          getRemote:
            - VERSION_NUMBER
          get:
            - BUILD_ID
```
## Configuration

You can supply `get` and/or `getRemote` in any request. If you use `getRemote` then you need to supply the `remoteJobId` option as well

### `get` 
Retrieve a variable from the current pipeline's meta-data

### `getRemote`
Retrieve a variable from another pipeline's meta-data. You also need to supply `remoteJobId` along with this parameter

### `remoteJobId`
Job ID of the pipeline to retrieve meta-data from that have been specified by `getRemote`
