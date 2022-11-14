resource "aws_security_group" "aspire_hyd_sg_alb" {
	name = "aspire_hyd_sg_alb"
	vpc_id = var.vpc_id

	dynamic "ingress" {
	  for_each = var.sg_ports_alb_ingress

	  content {
	  from_port = ingress.value
	  to_port = ingress.value
	  protocol = "tcp"
	  cidr_blocks = []
	  }

	}

	dynamic "egress" {
	  for_each = var.sg_ports_alb_egress

	  content {
	  from_port = egress.value
	  to_port = egress.value
	  protocol = -1
	  cidr_blocks = []
	  }
	  
	}

}


resource "aws_security_group" "aspire_hyd_sg_ecs" {
	name = "aspire_hyd_sg_ecs"
	vpc_id = var.vpc_id

	dynamic "ingress" {
	  for_each = var.sg_ports_ecs_ingress

	  content {
	  from_port = ingress.value
	  to_port = ingress.value
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
	  security_groups = [aws_security_group.aspire_hyd_sg_alb.id]
	  }

	}

	dynamic "egress" {
	  for_each = var.sg_ports_ecs_egress

	  content {
	  from_port = egress.value
	  to_port = egress.value
	  protocol = -1
	  cidr_blocks = ["0.0.0.0/0"]
	  }
	  
	}

}




