#!/bin/bash
#Create our first instance and upload a file into s3 bucket 
aws ec2 run-instances --image-id ami-14c5486b --count 1 --instance-type t2.micro --key-name shellscripting --security-group-ids --iam-instance-profile Name=PE_trainee_Admin_role --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Shell-assignment}, {Key=username,Value=Lokesh_Mahala},{Key=email_id,Value=lokesh.mahala@quantiphi.com}, {Key=Project,Value=PE_Training}]' --query Instances[0].InstanceId --user-data '#!/bin/bash 
echo "Hello Quantiphi This is final solution of my Shell Assignment schhi mai" 
aws s3 cp finalfile1.txt s3://2017lokesh/finalfile1.txt' 

#check our file present in s3 bucket or not 
aws s3 ls s3://2017lokesh/finalfile1.txt

#if our file not present in s3 bucket then this loop execute
while [ $? -ne 0 ]
do 
    aws s3 ls s3://2017lokesh/finalfile1.txt
    if [[ $? -eq 0 ]]; then #if our file find in s3 bucket then break our loop
      echo "file found Go on"
      break
    else
      echo "please wait some tym" # if our file is not present in s3 bucket then run our loop
      sleep 20
    fi
done

#after completion of uploading file into s3 bucket we create second instance and download that file 
aws ec2 run-instances --image-id ami-14c5486b --count 1 --instance-type t2.micro --key-name shellscripting --security-group-ids --iam-instance-profile Name=PE_trainee_Admin_role --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Shell-assignment}, {Key=username,Value=Lokesh_Mahala},{Key=email_id,Value=lokesh.mahala@quantiphi.com}, {Key=Project,Value=PE_Training}]' --query Instances[0].InstanceId --user-data '#!/bin/bash 
aws s3 cp s3://2017lokesh/finalfile1.txt finalfile1.txt'