
output "cloudwatch_metric_alarm_arn" {
  description = "The ARN of the Cloudwatch metric alarm."
  value       = try(aws_cloudwatch_metric_alarm.default_dynamic[0].arn, "")
}

output "cloudwatch_metric_alarm_id" {
  description = "The ID of the Cloudwatch metric alarm."
  value       = try(aws_cloudwatch_metric_alarm.default_dynamic[0].id, "")
}

output "log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group."
  #value       = aws_cloudwatch_log_group.log_group.*.arn
  value = element(concat(aws_cloudwatch_log_group.log_group.*.arn, [""]), 0)
}

output "log_group_name" {
  description = "The name of the log group."
  #value       = aws_cloudwatch_log_group.log_group.*.name
  value = element(concat(aws_cloudwatch_log_group.log_group.*.name, [""]), 0)
}
