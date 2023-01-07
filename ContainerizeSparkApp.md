# Containerize Spark Code

## Build Spark base image 
Spark installation provides the reuired tools to build a spark image with coustom dependencies.

Use following command to build base image (change 'username' with your DockerHub username after -r tag)
```shell
cd $SPARK_HOME

sudo bin/docker-image-tool.sh -r docker.io/username -t 3.1.1 -u 1000 -b java_image_tag=11-jre-slim -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

sudo docker images 
```
An image with your _username_ has to be created, for example '_username_/spark-py:3.1.3'

## Build Spark App Container
1. Create a simple pyspark application.
   ```
   mkdir ~/SparkContainer
   cd ~/SparkContainer
   ```
   As an example view [spark-s3](spark-s3/spark-s3.py). 
2. Create a requirements file for the application. As an example view [requirements for spark-s3](spark-s3/requirements.txt). 
3. Create a DockerFile to create the container. An example Dockerfile for spark-s3 is given below: 
   In the first link you can use the previoussly built spark-base image or anyother prebuilt image. (Ex [spark-s3/Dockerfile](spark-s3/Dockerfile))
   ```Dockerfile
   FROM abhayhk1/spark-py:3.1.3
   USER root
   WORKDIR /app

   RUN apt update
   RUN apt upgrade -y
   RUN apt install build-essential

   COPY requirements.txt .
   COPY spark-s3.py .
   RUN pip install -r requirements.txt
   ```

4. Build Dockerfile and push image to DockerHub. (Replace _username_ with DockerHub username, You can also replace _spark-k8s-app_ with any other name for the container)
   ```
   sudo docker build -t spark-k8s-app:1.0 .
   sudo docker tag spark-k8s-app:1.0 username/spark-k8s-app:1.0

   sudo docker login
   sudo docker image push username/spark-k8s-app:1.0
   ```