#Module      : CLOUDWATCH METRIC ALARM
#Description : Provides a CloudWatch Metric Alarm resource.

variable "enabled_basic" {
  type        = bool
  default     = false
  description = "Create a specific alarm, if true."
}

variable "alarm_name" {
  type        = string
  default     = ""
  description = "The descriptive name for the alarm."
}

variable "alarm_description" {
  type        = string
  default     = ""
  description = "The description for the alarm."
}

variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold."
  default     = "GreaterThanOrEqualToThreshold"
  sensitive   = true
}

variable "evaluation_periods" {
  type        = number
  default    = "60"
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "metric_name" {
  type        = string
  default     = "CPUUtilization"
  description = "The name for the alarm's associated metric."
}

variable "namespace" {
  type        = string
  default     = "AWS/EC2"
  description = "The namespace for the alarm's associated metric."
  sensitive   = true
}

variable "period" {
  type        = number
  default     = 120
  description = "The period in seconds over which the specified statistic is applied."
}

variable "statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric."
}

variable "threshold" {
  type        = number
  default     = 40
  description = "The value against which the specified statistic is compared."
}
variable "treat_missing_data" {
  type        = string
  default     = "missing"
  description = " (Optional) Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing."
}

variable "alarm_actions" {
  type        = list(any)
  default     = []
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state."
}

variable "actions_enabled" {
  type        = bool
  default     = true
  description = "Indicates whether or not actions should be executed during any changes to the alarm's state."
}

variable "insufficient_data_actions" {
  type        = list(any)
  default     = []
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state."
}

variable "ok_actions" {
  type        = list(any)
  default     = []
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state."
}

variable "instance_id" {
  type        = string
  default     = ""
  description = "The instance ID."
  sensitive   = true
}

variable "dimensions" {
  default     = {}
  description = "Dimensions for metrics."
}


# It will allow the creation of several alarms
variable "enabled_dynamic" {
  type        = bool
  default     = false
  description = "Creates a list of alarms, if true, consider the alarm_list variable."
}

variable "alarm_list" {
  type        = any
  default     = null
  description = <<-EOT
    type = map(object({
        alarm-cpu = {
        alarm_name      = "alarm_cpu"
        alarm_description = "This metric monitors ec2 cpu utilization exceeding 70%"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods  = "2"
        metric_name = "CPUUtilization"
        namespace = "AWS/EC2"
        period    = "60"
        statistic = "Average"
        # CPU Utilization threshold is set to 10 percent
        threshold         = "70"
        alarm_actions = null
        actions_enabled = null
        insufficient_data_actions = null
        ok_actions = null
        dimensions = {
            InstanceId = "i-082cb76ca0e5b43a7"   OR
            AutoScalingGroupName = "casper-aws-autoscaling"
        }
    }
    }))
    Required configuration for attach rule to Sg
    EOT
}

# A composite alarm

variable "create_composite_alarm" {
  type        = bool
  default     = false
  description = "Create alarm composite."
}
variable "com_actions_enabled" {
  type        = bool
  default     = true
  description = "(Optional, Forces new resource) Indicates whether actions should be executed during any changes to the alarm state of the composite alarm. Defaults to true."
}

variable "com_alarm_description" {
  description = "(Optional) The description for the composite alarm."
  default     = null
  type        = string
}

variable "com_alarm_name" {
  type        = string
  default     = null
  description = "(Required) The name for the composite alarm. This name must be unique within the region."
}

variable "com_alarm_actions" {
  type        = list(any)
  default     = []
  description = "(Optional) The set of actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
}
variable "com_alarm_rule" {
  type        = string
  default     = ""
  description = "(Required) An expression that specifies which other alarms are to be evaluated to determine this composite alarm's state. For syntax, see Creating a Composite Alarm. The maximum length is 10240 characters."
}

# CW dashboard

variable "create_dashboard" {
  type        = bool
  default     = false
  description = "if true, enable create cloudwatch dashboard"
}

variable "dashboard_name" {
  description = "(Required) The name of the dashboard."
  default     = null
  type        = string
}

variable "dashboard_body" {
  type        = string
  default     = null
  description = "(Required) The detailed information about the dashboard, including what widgets are included and their location on the dashboard. You can read more about the body structure in the documentation."
}

###############

# Canary resource

variable "create_syn_canary" {
  type        = bool
  default     = false
  description = "if true, enable create canary test"
}

variable "syn_runtime_version" {
  description = "(Required) Runtime version to use for the canary. Versions change often so consult the Amazon CloudWatch documentation for the latest valid versions. Values include syn-python-selenium-1.0, syn-nodejs-puppeteer-3.0, syn-nodejs-2.2, syn-nodejs-2.1, syn-nodejs-2.0, and syn-1.0."
  default     = null
  type        = string
}
variable "syn_start_canary" {
  type        = bool
  default     = false
  description = "(Optional) Whether to run or stop the canary."
}

variable "syn_s3_key_file" {
  description = "S3 key of your script. Conflicts with zip_file. canary_zip_inline.zip"
  default     = null
  type        = string
}

variable "syn_canary_name" {
  description = "Name to be used on Canary Test created."
  default     = null
  type        = string
}

variable "syn_s3_canary_bucket_name" {
  description = " (Required) Location in Amazon S3 where Synthetics stores artifacts from the test runs of this canary."
  default     = null
  type        = string
}
variable "syn_s3_canary_file_bucket_name" {
  description = " (Optional) Full bucket name which is used if your canary script is located in S3. The bucket must already exist. Specify the full bucket name including s3:// as the start of the bucket name. Conflicts with zip_file - Name to be used on Id bucket for read the code in Zip file."
  default     = null
  type        = string
}
variable "syn_s3_version" {
  description = " (Optional) S3 version ID of your script. Conflicts with zip_file."
  default     = null
  type        = string
}

variable "syn_role_arn" {
  description = "Role ARN for S3 and Canary Connection"
  default     = null
  type        = string
}

variable "syn_handler" {
  description = "(Required) Entry point to use for the source code when running the canary. This value must end with the string .handler"
  default     = null
  type        = string
}

variable "syn_delete_lambda" {
  description = "(Optional) Specifies whether to also delete the Lambda functions and layers used by this canary. The default is false"
  type        = bool
  default     = false
}
variable "syn_success_retention_period" {
  description = "(Optional) Number of days to retain data about successful runs of this canary. If you omit this field, the default of 31 days is used. The valid range is 1 to 455 days."
  type        = number
  default     = 3
}

# Canary resource in run_config

variable "syn_rc_active_tracing" {
  description = "(Optional) Whether this canary is to use active AWS X-Ray tracing when it runs. You can enable active tracing only for canaries that use version syn-nodejs-2.0 or later for their canary runtime."
  type        = bool
  default     = false
}
variable "syn_rc_timeout_in_seconds" {
  description = "(Optional) Number of seconds the canary is allowed to run before it must stop. If you omit this field, the frequency of the canary is used, up to a maximum of 840 (14 minutes)."
  type        = number
  default     = 60
}
variable "syn_rc_memory_in_mb" {
  description = "(Optional) Maximum amount of memory available to the canary while it is running, in MB. The value you specify must be a multiple of 64."
  type        = string
  default     = null
}

variable "syn_rc_environment_variables" {
  description = "(Optional) Map of environment variables that are accessible from the canary during execution. Please see AWS Docs for variables reserved for Lambda."
  type        = map(any)
  default     = null
}

# Canary resource in schedule

variable "syn_sch_expression" {
  description = "(Required) Rate expression or cron expression that defines how often the canary is to run."
  default     = 1
  type        = number
}

variable "syn_sch_duration_in_seconds" {
  description = "(Optional) Duration in seconds, for the canary to continue making regular runs according to the schedule in the Expression value."
  type        = number
  default     = null

}

# Log group

variable "create_log_group" {
  type        = bool
  default     = false
  description = "if true, enable create canary test"
}

variable "retention_days" {
  description = "Days to keep data saved."
  default     = 3
  type        = number
}

variable "log_group_name" {
  description = "Name to be used on Log Group created."
  default     = null
  type        = string
}

variable "log_stream_name" {
  description = "Name to be used on Log Stream created."
  default     = null
  type        = string
}



variable "create_metric_alarm_expression" {
  type        = bool
  default     = false
  description = "Enable alarm with expression."
}

variable "threshold_metric_id" {
  description = "If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function."
  type        = string
  default     = null
}

# Enables you to create an alarm based on a metric math expression. You may specify at most 20.

variable "query_expressions" {
  type = any
  default = [{
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "CPUUtilization (Expected)"
    return_data = "true"
  }]
  description = "values for metric query expression."
}

variable "query_metrics" {
  type = any
  default = [{
    id          = "m1"
    return_data = "true"
    metric_name = "CPUUtilization"
    namespace   = "AWS/EC2"
    period      = "120"
    stat        = "Average"
    unit        = "Count"
    dimensions = {
      InstanceId = "i-abc123"
    }
  }]
  description = "values for metric query metrics."
}