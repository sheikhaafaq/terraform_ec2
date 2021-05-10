#connect to aws cloud
provider "aws"  {

region="ap-south-1"
profile="default"

}

#create an ec2 instance 
resource "aws_instance"  "vm1"  {

ami="ami-010aff33ed5991201"
instance_type="t2.micro"
tags=  {  Name = "terraform vm1" }

}

#launch harddisk/ebs_volume
resource "aws_ebs_volume" "vol1" {
    availability_zone = aws_instance.vm1.availability_zone
    size=10
    tags = { Name = "vm1_vol" }
}

#Add extra volume to ec2 instance
resource "aws_volume_attachment" "att_vol1_vm1" {
  
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.vol1.id
  instance_id = aws_instance.vm1.id
 
}
