resource "aws_instance" "isu_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  availability_zone           = var.az
  vpc_security_group_ids      = [aws_security_group.this.id]
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}

// security group
resource "aws_security_group" "this" {
  name   = var.instance_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "egress_http" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
