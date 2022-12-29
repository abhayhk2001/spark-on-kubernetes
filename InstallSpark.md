# Setting Up VM 

## Setup VM
Execute the following commands to setup the environment and install docker.
```
sudo apt update && sudo apt -y full-upgrade
sudo apt autoremove
sudo apt-get remove docker containerd runc
sudo apt-get update
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

## Install Java 
For installing openJDK 11 follow the next steps:
```
sudo apt update
sudo apt install default-jre
java -version
sudo apt install default-jdk
javac -version
```

Set the _JAVA\_HOME_ variable using the following command:
```
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
```

## Install Spark
After installing JAVA install spark using the following commands. 
We have chosen a slightly old version of spark -> 3.0.3.
```
wget https://github.com/apache/spark/releases/tag/v3.1.3
tar xvf v3.0.3.tar.gz
mkdir /opt/spark
mv spark-3.0.3/* /opt/spark
```

Add spark to envirnment
```
vim ~/.bashrc
```
Add the following at the end of the script
```
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
```
Then run 
```
source ~/.bashrc
```

### Check if spark is installed correctly
If the command
```
spark-shell
```
works opens a prompt for running scala commands spark installation is complete.

