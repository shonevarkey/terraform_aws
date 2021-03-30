#Provider

provider "aws" {
  region     = "us-east-2"
  access_key = "SKIAYE7TEP5OH7SYSI3B"
  secret_key = "A3WXL4egks6VxNu5o0cxkuR4z2S/ghsmJMH6IuE9"
}


#VPC creation

resource "aws_vpc" "blog" {

  cidr_block       = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "blog"
  }

}

#Public 1

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.blog.id
  cidr_block = "172.16.0.0/18"
  map_public_ip_on_launch = true

  tags = {
    Name = "blog-public-1"
  }
}


#Public 2

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.blog.id
  cidr_block = "172.16.64.0/18"
  map_public_ip_on_launch = true
  tags = {
    Name = "blog-public-2"
  }
}

#Private 1

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.blog.id
  cidr_block = "172.16.128.0/18"
  map_public_ip_on_launch = false
  tags = {
    Name = "blog-private-1"
  }
}


#Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.blog.id

  tags = {
    Name = "blog-igw"
  }
}

#Elastic IP allocation

resource "aws_eip" "nat" {
  vpc      = true
}


#NAT Gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public2.id
  tags = {
    Name = "blog-nat"
  }
}

#SSH Keypair

resource "aws_key_pair" "keypair" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChYE8pvweLV2KNmZEty98JLrwCBp+zzwLJAsGvK98bJCV7AdYbAymqIngoObExTyKE2WUai8OL2ZlyokW0WTLgZz7Uk9AUnf3+7HJvBTDp3py4XsgpAFo3EFHEgLD7GVgrHTK0NBzMCNH9rqive2JY53JXZ0bpk7txIZ+a+zMjmpFXZsg6L9GbCphN4aBoe1DzBSkp6jJ7BMXgGOz2XXb7wQ9NEriAZ9OaTy2ldrwvV7EgkmJpewu9yoj8buXGr0lDQPYB8Jhd8zQC6t24VOCXblAPoIGhA+YKuGrucnMBo8Zu8fMSpT0K5CiX3tTJh5slTzjRDCsmuXNy8eXNk+WP ec2-user@ip-172-31-13-33.us-east-2.compute.internal"
  tags = {
    Name = "terraform-key"
  }
}


