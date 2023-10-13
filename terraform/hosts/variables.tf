variable "hosts" {
  default = {
    host1 = {
      host        = "ec2-54-235-15-22.compute-1.amazonaws.com"
      user        = "ubuntu"
      private_key = "/Users/huzaifa/Downloads/eksctl-vm-key.pem"
    }
  }
  description = "Hosts credentials"
  type = object({
    host1 = object({
      host        = string
      user        = string
      private_key = string
    })
  })
}