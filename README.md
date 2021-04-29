# qiot-pipelines

## Description
This repository contains all of the files necessary to deploy and run the 
pipeline used to build and deploy the QIOT services.

There is:
- one pipeline, a generic pipeline that is used for all of the services
deployed as part of the Covid19 app.
- one task for use in the pipeline.  The task compiles a Quarkus application.
  Other tasks are used in the pipeline but they are existing cluster tasks.
- a directory of pipeline runs containing a template for each service to be
  deployed.
- a file containing PVCs, one for each service so that the pipeline runs can
  be run simultaneously.
- a dockerfile for the Mandrel image used by the build task.
- a maven setting configmap pointing at the local nexus


## Pre-requisites
- Set up Kafka - add reference
- Set up PostgresQL - add reference
- Set up AMQ - add reference
- Set up Nexus - add reference
- Set up InfluxDB


## How to deploy manually
- Set up Nexus.  See separate section.

- Build the Mandrel image locally and push it to the OpenShift project if it
  doesn't exist already.

- The PVCs are labeled so that they can all be deleted together if desired.


## How to create and install the helm chart

Just call the script "build-chart.sh". It will create a folder target, copies everything in there
and build the chart via helm package. 

You can then install the chart using

```
$> helm install qiot-covid19-datahub-pipelines target/qiot-covid19-datahub-pipelines-0.1.2.tgz
```

Note, that your current user must have privileges to install Operators!


