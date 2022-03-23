module "cloudwatch_event" {
  source = "git::git@github.com:tomarv2/terraform-aws-cloudwatch-event.git?ref=v0.0.10"

  for_each = var.cloudwatch_event

  name         = lookup(each.value, "name", null)
  description  = lookup(each.value, "description", null)
  custom_input = lookup(each.value, "custom_input", null)
  suffix       = lookup(each.value, "suffix", null)
  schedule     = lookup(each.value, "schedule", null)

  deploy_event_rule   = var.deploy_cloudwatch_event_trigger
  deploy_event_target = var.deploy_cloudwatch_event_trigger

  target_arn = join("", aws_lambda_function.lambda.*.arn)
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

resource "aws_lambda_permission" "cloudwatch" {
  for_each = var.cloudwatch_event

  statement_id  = "allow_cloudwatch_${each.key}_trigger"
  action        = "lambda:InvokeFunction"
  function_name = join("", aws_lambda_function.lambda.*.function_name)
  principal     = "events.amazonaws.com"
  source_arn    = module.cloudwatch_event[each.key].cloudwatch_event_rule_arn
}
