#Security Group blog-bastion

resource "aws_security_group" "bastion" {

  name        = "blog-bastion"
  description = "allows 22 only"
  vpc_id      =  aws_vpc.blog.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "blog-bastion"
  }
}



#Security Group blog-webserver


resource "aws_security_group" "webserver" {

  name        = "blog-webserver"
  description = "allows 80,443 from all, 22 from bastion"
  vpc_id      =  aws_vpc.blog.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [  aws_security_group.bastion.id ]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "blog-webserver"
  }
}


#Security Group blog-database


resource "aws_security_group" "database" {

  name        = "blog-database"
  description = "allows 3306 from webserver, 22 from bastion"
  vpc_id      =  aws_vpc.blog.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [  aws_security_group.bastion.id ]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [ aws_security_group.webserver.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "blog-database"
  }
}

