# Spark on Kubernetes : A Complete Guide

## Setup of a Kubernetes Cluster on AWS
 Follow the instruction in the [README](cluster-setup/Kubespray%20on%20AWS.md) of cluster-setup directory.

## Spark Operator
Running spark on kubernetes cluster requires spark installation on the cluster and then using either spark-submit or a native SparkOperator to run the application code.

We have chosen the second approach which is more abstracted and easy to handle. To use SparkOperator we have to install the operator on the cluster.  

Follow the instructions [cluster-setup/install_sparkoperator.sh](cluster-setup/install_sparkoperator.sh) to install SparkOperator.

To learn more about operators in kubernetes click [here](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/). To learn more about SparkOperator click [here](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/user-guide.md).

## Containerize Spark Code
Create a new VM with ubuntu os, which will be used to build spark-base image and application as a docker containers and push it to DockerHub. To setup this VM  follow instructions in [InstallSpark.md](InstallSpark.md).

A spark base image is one used to run the code. After setup follow steps [here](ContainerizeSparkApp.md#build-spark-base-image) to build spark base image or skip [here](ContainerizeSparkApp.md#build-spark-app-container) to use a prebuilt spark base image and continue with building spark application container.

## Deploying Spark Application
At this point the following things are required to be completed:
1. Kubernetes Cluster Setup 
2. Spark Operator Installed
3. Docker Image Uploaded on DockerHub

Now we can move to the Kubernetes cluster and deploy this application. Follow [here](DeployingSparkApp.md) to deploy and manage a SparkApplication deployed through SparkOperator.