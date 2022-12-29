# Setting up and running Spark jobs on Kubernetes
mkdir files examples
echo -e "apiVersion: v1\nkind: Namespace\nmetadata:\n    name: spark-operator" > files/namespaces-spark.yaml
kubectl create -f files/namespaces-spark.yaml
kubectl create serviceaccount spark --namespace=default
kubectl create clusterrolebinding spark-operator-role --clusterrole=cluster-admin --serviceaccount=default:spark --namespace=default
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
helm install spark-operator/spark-operator --namespace spark-operator --set sparkJobNamespace=default --set webhook.enable=true --generate-name

vim examples/spark.yaml
# Add content for spark application

kubectl apply -f examples/spark.yaml
kubectl get pods
kubectl describe <pod_name>
kubectl delete -f examples/spark.yaml