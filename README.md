# blockchain-pipeline-job

Docker image to run Blockchain related jobs in Delivery Pipeline Jobs on IBM Cloud

To use a custom docker image in a pipeline template, use the following syntax:

```
  jobs:
  - name: Build
    type: builder
    artifact_dir: ''
    build_type: customimage
    docker_image: 'image_name'
    script: |-
      #!/bin/bash
      # Build all the things!
```

See also:
- [Pipeline YAML Format](https://github.com/open-toolchain/sdk/wiki/Pipeline-YAML-Format)
- [Working with custom Docker images](https://console.bluemix.net/docs/services/ContinuousDelivery/pipeline_custom_docker_images.html#custom_docker_images)
