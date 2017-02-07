variable "aws_region" {
    type = "string"
    default =  "us-east-1"
}
variable "source_access_block1" {
type = "string"
}
variable "source_access_block2" {
type = "string"
}

variable "ci_hostname" {
type = "string"
}
variable "ci_dns_zone_id" {
type = "string"
}
variable "ssl_cert_arn" {
type = "string"
}
variable "aws_profile" {
type = "string"
}
