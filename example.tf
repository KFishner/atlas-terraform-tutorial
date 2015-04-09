#--------------------------------------------------------------
# ACLs
#--------------------------------------------------------------
resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.main.id}"

  ingress {
      protocol = "tcp"
      rule_no = 1
      action = "allow"
      cidr_block =  "0.0.0.0/0"
      from_port = 5000
      to_port = 5000
  }
}


#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
}

#--------------------------------------------------------------
# Instance
#--------------------------------------------------------------
resource "aws_instance" "main" {
    instance_type = "t2.micro"

    # Trusty 14.04
    ami = "ami-ecb68a84"

    # This will create 1 instances
    count = 1

    subnet_id = "${aws_subnet.main.id}"
}
