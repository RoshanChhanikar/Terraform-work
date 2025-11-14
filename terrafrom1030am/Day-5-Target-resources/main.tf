
resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.nano"
    availability_zone = "us-east-1a"
    tags = {
        Name = "dev"
    }

}

resource "aws_s3_bucket" "name" {
    bucket = "hvdudvwgdvwugdcubbwdss"
  

}


#teragte resource we can user to apply specific resource level only belwo command is the reference 
#terraform apply -target=aws_s3_bucket.name

#try skip resource 