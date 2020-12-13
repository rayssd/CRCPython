resource "aws_instance" "RHEL8" {
  ami           = "ami-044c46b1952ad5861"
  instance_type = "t2.micro"
  tags = {
    Name = "RHEL8"
  }
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-0f158b0f26f18e619"
  instance_type = "t2.micro"
  tags = {
    Name = "Ubuntu"
  }
}

resource "aws_vpc" "default" {
  cidr_block = "172.31.0.0/16"

}

resource "aws_subnet" "default" {
  cidr_block              = "172.31.0.0/20"
  vpc_id                  = aws_vpc.default.id
  map_public_ip_on_launch = true
}

resource "aws_security_group" "My-Demo-Security-Group" {
  description = "My-Demo-Security-Group"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]

  ingress = [
    {
      cidr_blocks = [
        "122.199.41.244/32",
      ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks = [
        "122.199.41.244/32",
      ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks = [
        "122.199.41.244/32",
      ]
      description      = ""
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 53
    },
    {
      cidr_blocks = [
        "122.199.41.244/32",
      ]
      description      = ""
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups  = []
      self             = false
      to_port          = 53
    },
    {
      cidr_blocks = [
        "122.199.41.244/32",
      ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
  ]
  name = "My-Demo-Security-Group"

  tags   = {}
  vpc_id = "vpc-fbe4fb9c"

  timeouts {}
}
