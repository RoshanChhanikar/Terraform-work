resource "aws_instance" "dev" {
    ami = "ami-07860a2d7eb515d9ab"
    instance_type = "t2.micro"
    tags = {
      Name = "dev"
    }

    # lifecycle {
    #   create_before_destroy = true
    # }
    # lifecycle {
    #   ignore_changes = [tags,  ]
    # }
    # lifecycle {
    #   prevent_destroy = true
    # }
  
}