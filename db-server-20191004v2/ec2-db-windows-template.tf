resource "aws_instance" "c33tftpdb01" {
    ami                         = "ami-090c6ac3ef1d21525"
    availability_zone           = "us-east-1a"
    ebs_optimized               = false
    instance_type               = "m5.large"
    monitoring                  = true
    key_name                    = "AWSToolsKey1"
    subnet_id                   = "subnet-873603de"
    vpc_security_group_ids      = ["sg-33f71655", "sg-bec466d8", "sg-71c76517"]
    associate_public_ip_address = false
    disable_api_termination     = true
    private_ip                  = ""
    source_dest_check           = true
    iam_instance_profile     = "allow-all-ssm"
    user_data            = "${file("userdata2.txt")}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 100
        delete_on_termination = true
    }

    tags {
        "Environment" = "Test"
        "Description" = "c33tftpdb01"
        "SnapshotSchedule" = "default"
        "Name" = "c33tftpdb01"
        "Author" = "Gabriel"
    }
}

resource "aws_ssm_association" "c33tftpdb01" {
  name        = "awsconfig_Domain_d-90673a6e07_sigue.local",
  instance_id = "${aws_instance.c33tftpdb01.id}"
    }