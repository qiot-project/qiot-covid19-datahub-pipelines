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


## How to deploy 
- Set up Nexus.  See separate section.

- Build the Mandrel image locally and push it to the OpenShift project if it
  doesn't exist already.


- Log in to OpenShift and the project that the services are to be deployed
  into.

- Create the config map for the maven settings
`oc create -f maven-settings-xml.yaml`

- Create the PVCs for all of the pipeline instantiations
`oc create -f pvcs.yaml`

The PVCs are labeled so that they can all be deleted together if desired.

- Deploy the task to be used in the pipeline.
`oc create -f tasks/quarkus-build-task.yaml`

- Deploy the pipeline to be run
`oc create -f pipelines/qiot-jvm-deployment-pipeline.yaml

- For each service to deploy, run the pipelineRun
`oc create -f pipeline_runs/localization-plr.yaml
