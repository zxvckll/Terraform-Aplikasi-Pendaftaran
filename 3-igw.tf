resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.rawat-jalan.id

    tags = {
      Name = "igw rawat-jalan"
    }
    
}