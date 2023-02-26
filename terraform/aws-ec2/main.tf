# pulls the ami of the latest image build
data "aws_ami" "ec2-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}


# configure the aws instance
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ec2-ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  tags                   = var.tags

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.ebs_volume_size
  }

  # this code can be used if you prefer to create the ec2 instance and provision it at the same time instead of creating an image with packer first
  # if you do this then comment out the "aws_ami" data resource first

  # make sure instance is ready for ansbile to be run; could also use depends_on = [aws_instance.ec2]
      provisioner "remote-exec" {
          inline = ["echo 'Ready to accept connections'"]

      connection {
        type        = "ssh"
        host        = self.public_ip
        user        = var.ec2_user
        private_key = file(var.private_key)
      }
  }

    # runs ansible playbook on instance
    provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.ec2_user}' -i '${aws_instance.ec2.public_dns},' --private-key '${var.private_key}' ../../ansible/servers/test.yaml"
    }
}

