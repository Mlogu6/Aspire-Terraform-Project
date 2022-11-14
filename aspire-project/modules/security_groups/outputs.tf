output "sg_alb_id" {
	value = aws_security_group.aspire_hyd_sg_alb.id
}

output "sg_ecs_id" {
	value = aws_security_group.aspire_hyd_sg_ecs.id
}