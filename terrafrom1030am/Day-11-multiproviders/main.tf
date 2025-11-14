resource "aws_instance" "name" {
  ami="ami-07860a2d7eb515d9a" 
  instance_type = "t2.micro"

}

resource "aws_s3_bucket" "name" {
    bucket = "tybuwbdsjbcscj"
    provider = aws.oregon
  
}