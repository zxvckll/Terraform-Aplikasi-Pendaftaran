resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.rawat-jalan.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-us-east-1a rawat-jalan"
  }
}
resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.rawat-jalan.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-us-east-1b rawat-jalan"
  }
}
resource "aws_subnet" "public-us-east-1a" {
  vpc_id            = aws_vpc.rawat-jalan.id
  cidr_block        = "10.0.64.0/19"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-us-east-1a rawat-jalan"
  }
}
resource "aws_subnet" "public-us-east-1b" {
  vpc_id            = aws_vpc.rawat-jalan.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-us-east-1b rawat-jalan"
  }
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds_subnet_group"
  subnet_ids = ["${aws_subnet.private-us-east-1a.id}",
  "${aws_subnet.private-us-east-1b.id}"]

  tags = {
    Name = "RDS subnet group"
  }
}


