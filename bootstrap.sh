#!/usr/bin/env bash

#  boothstrap.sh is run when EC2 instance is initialised. Script is triggered from instance UserData
#  which set by Clooudformation tmeplate ./clooudformation/ec2-infraprod.yaml
#
#  copyright jussi.heinonen@ft.com, 27.06.2017

OUTPUT="/var/log/bootstrap.log"
ROOTDIR='/opt/methode'
mkdir -p ${ROOTDIR}
PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA05/uxgH59xqpz/8XlsyENn3tlJiKIloTn6ZJb0aBDvqagoXzO7DuDxZGF+k+iBZCnX+wVZov7dhBPY4qQ9ugW5icMDVnjoT8r3VWpyOFppZEp6K1vRVE7WVcx8DR9ydXjjQJgACZKMiB5k0qI0j8wSuHGCj6OjeImTThKI8KgkrmZgMUA7N9siRng5TnV1xtx5fPzS4ouigSjjPGeZOqbNLvgcWLJ3NXQLApmPuweOY0ou8MCpZfiOiIP5adImxNOrvn1Q2FB33+tqM6fGyXExhZTFBbV1m+cXXd5xUhOU1k8vo8RPthILV2s9xU634i4QvXfrRHjmWK8RFnsO8+lQ=="

echo  "BEGIN - $(date)" | tee -a ${OUTPUT}
if [[ "${PPID}" -eq "1" ]]; then
  echo "Parent PID 1 indicates we are running inside Docker container, skip tagging and package installation" | tee -a ${OUTPUT}
else
  # Create Name tag if not already done so
  TAGGED=$(aws ec2 describe-instances --region $(curl -s http://169.254.169.254/latest/meta-data/hostname | cut -d . -f 2) \
  --instance-ids $(curl -s http://169.254.169.254/latest/meta-data/instance-id) \
  --filters "Name=tag:Name",Values="$(curl -s http://169.254.169.254/latest/meta-data/hostname)" \
  --query 'Reservations[].Instances[].PrivateIpAddress' --output text)

  if [[ -z ${TAGGED} ]]; then
    echo "Setting hostname in AWS console" | tee -a ${OUTPUT}
    /usr/bin/aws ec2 --region $(curl -s http://169.254.169.254/latest/meta-data/hostname | cut -d . -f 2) delete-tags --resources $(curl -s http://169.254.169.254/latest/meta-data/instance-id) --tags Key=Name
    /usr/bin/aws ec2 --region $(curl -s http://169.254.169.254/latest/meta-data/hostname | cut -d . -f 2) create-tags --resources $(curl -s http://169.254.169.254/latest/meta-data/instance-id) --tags Key=Name,Value=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
    echo "Hostname set" | tee -a ${OUTPUT}
  else
    echo "Skip tagging" | tee -a ${OUTPUT}
  fi
fi

# Install packages for deployment unless already installed
docker --version &> /dev/null || yum install -y docker | tee -a ${OUTPUT}
git --version &> /dev/null || yum install -y git | tee -a ${OUTPUT}
yum update -y

# Ensure Docker is running
/sbin/service docker start

# Add Jenkins user and related configuration
useradd -m jenkins
mkdir /home/jenkins/.ssh
echo ${PUB_KEY} > /home/jenkins/.ssh/authorized_keys
chown -R jenkins: /home/jenkins/.ssh/
echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins
chmod 440 /etc/sudoers.d/jenkins
