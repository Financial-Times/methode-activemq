# Methode Prime Server deployment

Methode Prime Server is deployed by Cloudformation.

Cloudformation template [prime-server-ft-tech-editorial-prod.yaml](http://git.svc.ft.com/projects/NS/repos/methode-activemq/browse/cloudformation/prime-server-ft-tech-editorial-prod.yaml) creates autoscaling group and launch configuration that spins up Prime Server.

## Deploying Primer Server

 1. Log on to _ft-tech-editorial-prod_ AWS account
 2. Go to CloudFormation and click _Create Stack_
 3. In _Choose a template_ section click _Choose file_, select tempalate _methode-activemq/cloudformation/prime-server-ft-tech-editorial-prod.yaml_ and click _Next_
 4. Enter _Stack name_ name eg. methode-prime-server-prod and click _Next_
 5. On _Options_ page click _Next_
 6. On _Review_ page click _Create_
 7. Wait for about 5-10 minutes and you should then find new instance with name _FTAPP012-WVIR-P_ appearing on list of running EC2 instances
