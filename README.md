# methode-activemq

Docker image to run ActiveMQ broker for Methode

# Building image

`docker build -t methode-activemq:dev .`

# Launching image

The following command starts ActiveMQ broker and creates port forwarding
such as ActiveMQ WebConsole available at http://0.0.0.0:80/

## Background

```
docker run -d \
-p 1883:1883 \
-p 5672:5672 \
-p 80:8161 \
-p 61613:61613 \
-p 61614:61614 \
-p 61616:61616 \
-t methode-activemq:dev
```

## Foreground

```
docker run \
-p 1883:1883 \
-p 5672:5672 \
-p 80:8161 \
-p 61613:61613 \
-p 61614:61614 \
-p 61616:61616 \
-it methode-activemq:dev
```


# Setting up runtime on Amazon Linux

```
yum install -y docker git && service docker start`
useradd -m jenkins
mkdir /home/jenkins/.ssh
cp /root/.ssh/authorized_keys /home/jenkins/.ssh/
chown -R jenkins: /home/jenkins/.ssh/
echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins
chmod 440 /etc/sudoers.d/jenkins
``
