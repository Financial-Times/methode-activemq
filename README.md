# methode-activemq
Docker image to run ActiveMQ broker for Methode

# Building image

`sudo docker build -t methode-activemq:dev .`

# Launching image

The following command starts ActiveMQ broker and creates port forwarding
such as ActiveMQ WebConsole available at http://0.0.0.0:8161/

```
sudo docker run \
-p 1883:1883 \
-p 5672:5672 \
-p 8161:8161 \
-p 61613:61613 \
-p 61614:61614 \
-p 61616:61616 \
-it methode-activemq:dev
```

# Runtime setup on Amazon Linux

`yum install -y docker git`
