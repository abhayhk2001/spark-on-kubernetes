FROM abhayhk1/spark-py:3.1.3
USER root
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apt-get install wget -y
RUN wget https://gist.githubusercontent.com/abhayhk2001/9e5c49c4f108dc420c3c3b2171f6e82c/raw/a0e7b10ea569e45169dcbefc3d1f5b9845625022/spark-job.py

# bin/docker-image-tool.sh -r docker.io/abhayhk1 -t 3.1.3 -u 1000 -b java_image_tag=11-jre-slim -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

