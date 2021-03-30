#Instance webserver

resource "aws_instance" "webserver" {

  ami  =  "ami-05d72852800cbf29e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  subnet_id  = aws_subnet.public1.id
  vpc_security_group_ids = [ aws_security_group.webserver.id ]
  user_data = file("apache-install.sh")

  tags = {
    Name = "blog-webserver"
  }
}



#Instance bastion


resource "aws_instance" "bastion" {

  ami  =  "ami-05d72852800cbf29e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  subnet_id  = aws_subnet.public2.id
  vpc_security_group_ids = [ aws_security_group.bastion.id ]

  tags = {
    Name = "blog-bastion"
  }
}


#Instance database

resource "aws_instance" "database" {

  ami  =  "ami-05d72852800cbf29e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name

  subnet_id  = aws_subnet.private1.id
  vpc_security_group_ids = [ aws_security_group.database.id ]
  user_data = file("mariadb-install.sh")
  tags = {
    Name = "blog-database"
  }
}


