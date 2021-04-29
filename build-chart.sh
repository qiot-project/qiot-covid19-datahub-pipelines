#!/bin/sh
#
# Script to build the structure of the helm chart to install 
# necessary operators and the pipelines.
# 
# This script will create a target folder which will always be deleted first
# - It will then copy everything from helm-chart to that folder 
# - Then it will copy the pipelines and -runs into a templates folder
# - Then it will create the chart.tgz which can be installed on Kubernetes / OpenShift
# 
# PREREQ:
# Have helm installed as local CLI tool
# On mac you could use brew install helm
#

SOURCE=$(basename "$0")
BASEDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

TARGET_BASE=$BASEDIR/target
TARGET=$TARGET_BASE/chart

echo "Source: " $SOURCE
echo "BASE  : " $BASEDIR
echo "TARGET: " $TARGET

# delete TARGET
rm -r $TARGET_BASE
mkdir -p $TARGET
cp -r $BASEDIR/helm-chart/* $TARGET/
mkdir $TARGET/templates

echo "Copying everything to $TARGET"
# copy tasks
cp $BASEDIR/tasks/* $TARGET/templates/

# copy pipeline and -runs
cp $BASEDIR/pipelines/* $TARGET/templates/
cp $BASEDIR/pipeline_runs/* $TARGET/templates/
cp $BASEDIR/pvcs.yaml $TARGET/templates/
cp $BASEDIR/maven-settings-using-nexus.yaml $TARGET/templates/

echo "Building helm chart"
helm package $TARGET -d $TARGET_BASE -u 
