resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "kubernetes_master" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t3.medium"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = ["${aws_security_group.k8s.id}"]

 tags = {
    Name = "kubernetes_master"
  }
}
resource "aws_instance" "kubernetes_worker" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t3.medium"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = ["${aws_security_group.k8s.id}"]
  count = 2

 tags = {
    Name = "kubernetes_worker-${count.index}"
  }
}

resource "aws_security_group" "k8s" {
  name = "Ports 22"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

 tags = {
    Name = "k8s"
  }
}

resource "local_file" "inventory" {
  filename = "./ansible_cm/inventory.ini"
  file_permission = "0644"
  content  = <<EOF
[kubernetes_master]
${aws_instance.kubernetes_master.public_dns}

[kubernetes_worker1]
${aws_instance.kubernetes_worker[0].public_dns}

[kubernetes_worker2]
${aws_instance.kubernetes_worker[1].public_dns}

EOF
}

resource "local_file" "host_script" {
  filename = "./add_host.sh"
  file_permission = "0700"
  content = <<EOF
#!/bin/bash
echo "Setting SSH Key"
#ssh-add ~/<PATH TO SSH KEYFILE>.pem
echo "Adding IPs"
ssh-keyscan -H ${aws_instance.kubernetes_master.public_dns} >> ~/.ssh/known_hosts
ssh-keyscan -H ${aws_instance.kubernetes_worker[0].public_dns} >> ~/.ssh/known_hosts
ssh-keyscan -H ${aws_instance.kubernetes_worker[1].public_dns} >>  ~/.ssh/known_hosts

EOF
}

resource "null_resource" "add_host_entry" {
  triggers = {
    order = local_file.host_script.id
  }
  provisioner "local-exec" {
    command = "sleep 10 && ./add_host.sh"
  }
}
