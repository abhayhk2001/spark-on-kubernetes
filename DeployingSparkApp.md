# Deploying Spark Application
SSH into control host which has access to run kubectl commands.

## Create a SparkApplication
Create a spark-app.yaml file.
   ```
   vim spark-app.yaml
   ```
   Fill the file witl SparkApplication. Format to for a SparkApplication.yaml file is given [here](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/user-guide.md#writing-a-sparkapplication-spec). For example [this](spark-s3/spark-s3.yaml) is the SparkApplication yaml file to deploy spark-s3.py in previous section.
   ```
   apiVersion: "sparkoperator.k8s.io/v1beta2"
   kind: SparkApplication
   metadata:
      name: pyspark-on-k8s
      namespace: default
   spec:
      type: Python
      mode: cluster
      image: "abhayhk1/spark-k8s-app:1.0"
      pythonVersion: "3"
      imagePullPolicy: Always
      mainApplicationFile: local:///app/spark-s3.py
      sparkVersion: "3.0.0"
      restartPolicy:
         type: Never
      driver:
         cores: 1
         coreLimit: "1200m"
         memory: "512m"
         labels:
         version: 3.0.0
         serviceAccount: spark
      executor:
         cores: 1
         instances: 2
         memory: "1000m"
         labels:
            version: 3.0.0
         deps:
            jars:
               [
               "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar",
               "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar",
               ]
   ```

## Managing SparkApplication 
Applying the SparkApplication
```
kubectl apply <file>.yaml
```

Getting Pods during execution
```
kubectl get pods 
```

Getting the logs of of a completed execution
```
kubectl logs <master-pod-name>
```

Deleting SparkApplication
```
kubectl delete <file>.yaml
```