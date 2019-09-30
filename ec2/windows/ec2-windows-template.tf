resource "aws_instance" "ec2" {
    ami                         = "ami-30683a26"
    availability_zone           = "us-east-1e"
    ebs_optimized               = false
    instance_type               = "t2.small"
    monitoring                  = true
    key_name                    = "AWSToolsKey1"
    subnet_id                   = "subnet-004fd73c"
    vpc_security_group_ids      = ["sg-33f71655", "sg-bcfc5eda", "sg-71c76517"]
    associate_public_ip_address = false
    private_ip                  = ""
    source_dest_check           = true
    iam_instance_profile     = "allow-all-ssm"
    user_data            = "${file("userdata.txt")}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 100
        delete_on_termination = true
    }

    tags {
        "Environment" = "Test"
        "Description" = "ec2"
        "SnapshotSchedule" = "default"
        "Name" = "ec2"
        "Author" = "Gabriel"
    }
}

resource "aws_ssm_association" "ec2" {
  name        = "awsconfig_Domain_d-90673a6e07_sigue.local",
  instance_id = "${aws_instance.ec2.id}"
    }