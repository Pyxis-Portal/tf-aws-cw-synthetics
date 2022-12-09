locals {
  tags = {
    terraform = true
  }
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  count      = var.create_syn_canary ? 1 : 0
  depends_on = [null_resource.previous]

  create_duration = "60s"
}

resource "aws_cloudwatch_dashboard" "cw_dashboard" {
  count          = var.create_dashboard ? 1 : 0
  dashboard_name = var.dashboard_name
  dashboard_body = var.dashboard_body

}

resource "aws_cloudwatch_composite_alarm" "composite_alarm" {
  count             = var.create_composite_alarm ? 1 : 0
  actions_enabled = var.com_actions_enabled
  alarm_description = var.com_alarm_description
  alarm_name        = "${var.com_alarm_name}-comp"
  alarm_actions = var.com_alarm_actions
  alarm_rule    = var.com_alarm_rule

  
  depends_on = [
    aws_cloudwatch_metric_alarm.default_dynamic,
    aws_cloudwatch_metric_alarm.defalut
  ]


}


#Module      : CLOUDWATCH METRIC ALARM
#Description : Terraform module creates Cloudwatch Alarm on AWS for monitoriing AWS services.
resource "aws_cloudwatch_metric_alarm" "defalut" {
  count = var.enabled_basic ? 1 : 0

  alarm_name                = var.alarm_name
  alarm_description         = var.alarm_description
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.threshold
  treat_missing_data        = var.treat_missing_data
  alarm_actions             = var.alarm_actions
  actions_enabled           = var.actions_enabled
  insufficient_data_actions = var.insufficient_data_actions
  ok_actions                = var.ok_actions
  dimensions                = var.dimensions
  tags                      = merge(local.tags )
  
}
resource "aws_cloudwatch_metric_alarm" "default_dynamic" {  
  for_each = var.enabled_dynamic ? var.alarm_list : {}

  
  alarm_name                = each.value.alarm_name
  alarm_description         = each.value.alarm_description
  comparison_operator       = each.value.comparison_operator
  evaluation_periods        = each.value.evaluation_periods
  metric_name               = each.value.metric_name
  namespace                 = each.value.namespace
  period                    = each.value.period
  statistic                 = each.value.statistic
  threshold                 = each.value.threshold
  treat_missing_data        = each.value.treat_missing_data
  alarm_actions             = length(each.value.alarm_actions) == 0 ? [] : each.value.alarm_actions
  actions_enabled           = each.value.actions_enabled
  insufficient_data_actions = each.value.insufficient_data_actions
  ok_actions                = each.value.ok_actions
  dimensions                = each.value.dimensions
  tags                      = merge(local.tags )
  
}

resource "aws_cloudwatch_metric_alarm" "expression" {
  count = var.create_metric_alarm_expression ? 1 : 0

  alarm_name                = var.alarm_name
  alarm_description         = var.alarm_description
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  threshold                 = var.threshold
  treat_missing_data        = var.treat_missing_data
  alarm_actions             = var.alarm_actions
  actions_enabled           = var.actions_enabled
  insufficient_data_actions = var.insufficient_data_actions
  ok_actions                = var.ok_actions
  tags                      = merge(local.tags )
  dynamic "metric_query" {
    for_each = var.query_expressions
    content {
      id          = metric_query.value["id"]
      expression  = metric_query.value["expression"]
      label       = metric_query.value["label"]
      return_data = metric_query.value["return_data"]
    }
  }

  dynamic "metric_query" {
    for_each = var.query_metrics
    content {
      id          = metric_query.value["id"]
      return_data = metric_query.value["return_data"]
      metric {
       metric_name = metric_query.value["metric_name"]
       namespace   = metric_query.value["namespace"]
       period      = metric_query.value["period"]
       stat        = metric_query.value["stat"]
       unit        = metric_query.value["unit"]
       dimensions  = metric_query.value["dimensions"]
      }
    }
  }
  threshold_metric_id = var.threshold_metric_id

}


resource "aws_synthetics_canary" "canary_watch_service" {
  count                = var.create_syn_canary ? 1 : 0
  name                 = var.syn_canary_name
  artifact_s3_location = "s3://${var.syn_s3_canary_bucket_name}/canary/${var.syn_canary_name}"
  execution_role_arn   = var.syn_role_arn
  handler              = var.syn_handler
  s3_bucket            = var.syn_s3_canary_file_bucket_name
  s3_key               = var.syn_s3_key_file
  s3_version           = var.syn_s3_version
  start_canary         = var.syn_start_canary
  #zip_file             = "${var.zip_file}"
  runtime_version      = var.syn_runtime_version
  delete_lambda        = var.syn_delete_lambda

  success_retention_period = var.syn_success_retention_period

  run_config {
    active_tracing     = var.syn_rc_active_tracing
    timeout_in_seconds = var.syn_rc_timeout_in_seconds
    memory_in_mb = var.syn_rc_memory_in_mb
    environment_variables = var.syn_rc_environment_variables

  }


  schedule {
    expression = "rate(${var.syn_sch_expression} ${var.syn_sch_expression == 1 ? "minute" : "minutes"})"
    duration_in_seconds = var.syn_sch_duration_in_seconds

  }

  depends_on = [time_sleep.wait_60_seconds]
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.create_log_group ? 1 : 0
  name              = var.log_group_name
  retention_in_days = var.retention_days
}


resource "aws_cloudwatch_log_stream" "log_stream" {
  count          = var.create_log_group ? 1 : 0
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.log_group[count.index].name

  depends_on = [
    aws_cloudwatch_log_group.log_group
  ]

}
