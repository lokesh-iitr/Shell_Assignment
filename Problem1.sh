#file at client end

#!/bin/bash
chmod 777 Jump.sh
chmod 777 production.sh
scp -i /home/lokesh/Desktop/New/shellscripting1.pem /home/lokesh/Desktop/Assign/Jump.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:
scp -i /home/lokesh/Desktop/New/shellscripting1.pem /home/lokesh/Desktop/Assign/production.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:
scp -i /home/lokesh/Desktop/New/shellscripting1.pem /home/lokesh/Desktop/Assign/Problem2.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:
scp -i /home/lokesh/Desktop/New/shellscripting1.pem /home/lokesh/Desktop/Assign/Problem1.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:

ssh -i /home/lokesh/Desktop/Assign/shellscripting1.pem ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com



#files at jump server end

#!/bin/bash

mkdir lokesh

mv Jump.sh lokesh
mv production.sh lokesh
mv Problem1.sh lokesh
mv Problem2.sh lokesh


id=$(aws autoscaling describe-auto-scaling-instances --query "AutoScalingInstances[?AutoScalingGroupName=='shellscripting'].InstanceId" --output text) 
ip=$(aws ec2 describe-instances --instance-ids $id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text )


scp production.sh ec2-user@$ip:/home/ec2-user
scp Problem1.sh ec2-user@$ip:/home/ec2-user
scp Problem2.sh ec2-user@$ip:/home/ec2-user

ssh -t -t ec2-user@$ip /home/ec2-user/production.sh

#file at production server end 
#!/bin/bash

mkdir mahala
mv Problem1.sh mahala
mv Problem2.sh mahala
cd mahala

sudo yum update
sudo yum install git
git init
git add *
git commit -m "Shell Assignment submission"
git remote add origin git@github.com/lokesh-iitr/Shell_Assignment.git
git push -u origin masters