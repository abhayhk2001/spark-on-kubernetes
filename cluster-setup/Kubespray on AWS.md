## Kubespray Setup :

1. Clone the repo : https://github.com/kubernetes-sigs/kubespray.git
   ```
   git clone https://github.com/kubernetes-sigs/kubespray.git
   ```

2. cd in to kubespray/contrib/terraform/aws and rename credentials.tfvars.example to credentials.tfvars
   ```
   cd kubespray/contrib/terraform/aws
   mv credentials.tfvars.example credentials.tfvars
   ```

3. Fill the AWS credential values in credentials.tfvars file
   ```

   AWS_ACCESS_KEY_ID = "****"

   AWS_SECRET_ACCESS_KEY = "****"

   AWS_SSH_KEY_NAME = "****"

   AWS_DEFAULT_REGION = "****"
   ```


4. Modify the values in terraform.tfvars, by modifying the number fo master and number of workers. For spark the minimum requirement in terms of the VM type is **c4.xlarge**.

5. For ubuntu 22.04 instances change the data "aws_ami" "distro" structure in variables.tf to 
   ```
   data "aws_ami" "distro" {
      most_recent = true
      filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
      }

      filter {
      name = "virtualization-type"
      values = ["hvm"]
      }

      owners = ["099720109477"]
   }
   ```

   Replace the debian ami with the above config.

6. Initialize Terraform and planning steps 
   Open a terminal and execute the following commands.
   ```
   terraform init
   terraform plan -out <terraform-plan-name> -var-file=credentials.tfvars
   ```

7. Execute the plan
   ```
   terraform apply "<terraform-plan-name>"
   ```
   Wait for the infrastructure to be provisioned.

8. Verify if instance are running then public ssh into bastion and run the following, 
   ```
   sudo apt update
   sudo apt upgrade -y
   sudo apt install python3-pip python-is-python3 -y
   ```

9. Clone the kubespray repo and install Ansible and other dependencies by running
   ```
   git clone https://github.com/kubernetes-sigs/kubespray.git
   cd kubespray/
   python -m pip install -r requirements.txt
   export PATH=/home/ubuntu/.local/bin:$PATH
   ```

10. Rename *inventory/sample* as *inventory/mycluster*
    ```
    cp -rfp inventory/sample inventory/mycluster
    ```

11. Update Ansible inventory file with inventory builder. Include Private IPs of the VMs, and run the command.
    ```
    declare -a IPS=(<master-node> <worker-node-1> <worker-node-2> … <worker-node-n>)
    ```
    Next create inventory file by running the following command: 
    ```
    CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
    ```

12. Run the ansible playbook by 
    ```
    ansible-playbook -i inventory/mycluster/hosts.yaml –-private-key=path/to/the/.pem/file --become --become-user=root cluster.yml
    ```
   Setup usually take 10 min


## Post Setup scripts
SSH into master and run the following commands
```
ssh ubuntu@<master_ip>
mkdir .kube
sudo cp /etc/kubernetes/admin.conf .kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get all
```

### To access the kubernetes cluster through bastion (or any remote machine with ssh access to master) - Not Completed

- Installing kubectl
  ```
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y kubectl
  ``` 

- SSH into the required VM
  ```
  mkdir ~/.kube
  scp ubuntu@10.250.212.28:~/.kube/config ~/.kube/config
  ```

Replace the server URL within ~/.kube/config of the master node by load balancer’s IP address or Domain, Copy this entire configuration and paste it into Bastion’s ~/.kube/config

