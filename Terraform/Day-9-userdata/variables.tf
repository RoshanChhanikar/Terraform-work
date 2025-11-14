variable "ami_id" {
    description = "passing ami values"
    default = "ami-07860a2d7eb515d9a"
    type = string
  
}
variable "type" {
    description = "passing values to instance type"
    default = "t2.micro"
    type = string
  
}