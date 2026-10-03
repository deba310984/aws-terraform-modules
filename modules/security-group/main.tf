# modules/security-group/main.tf

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = var.name })
}

# count-indexed rules let the caller pass a variable-length list. Each rule
# uses either cidr_blocks or source_security_group_id (a trusted tier).
resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  description       = var.ingress_rules[count.index].description
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol

  cidr_blocks              = var.ingress_rules[count.index].cidr_blocks
  source_security_group_id = var.ingress_rules[count.index].source_security_group_id
}

resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  type              = "egress"
  security_group_id = aws_security_group.this.id
  description       = var.egress_rules[count.index].description
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol

  cidr_blocks              = var.egress_rules[count.index].cidr_blocks
  source_security_group_id = var.egress_rules[count.index].source_security_group_id
}
