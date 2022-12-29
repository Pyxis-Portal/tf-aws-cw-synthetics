# CloudWatch Module

- Creating of alarms.
- Creating of a composite alarm.
- Creating of dashboard.
- Creating of monitoring application for Synthetics Canaries.
- Creating of log groups.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.61.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_composite_alarm.composite_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_composite_alarm) | resource |
| [aws_cloudwatch_dashboard.cw_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_cloudwatch_metric_alarm.defalut](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.default_dynamic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.expression](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_synthetics_canary.canary_watch_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/synthetics_canary) | resource |
| [null_resource.previous](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_60_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_enabled"></a> [actions\_enabled](#input\_actions\_enabled) | Indicates whether or not actions should be executed during any changes to the alarm's state. | `bool` | `true` | no |
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | The list of actions to execute when this alarm transitions into an ALARM state from any other state. | `list(any)` | `[]` | no |
| <a name="input_alarm_description"></a> [alarm\_description](#input\_alarm\_description) | The description for the alarm. | `string` | `""` | no |
| <a name="input_alarm_list"></a> [alarm\_list](#input\_alarm\_list) | type = map(object({<br>    alarm-cpu = {<br>    alarm\_name      = "alarm\_cpu"<br>    alarm\_description = "This metric monitors ec2 cpu utilization exceeding 70%"<br>    comparison\_operator = "GreaterThanOrEqualToThreshold"<br>    evaluation\_periods  = "2"<br>    metric\_name = "CPUUtilization"<br>    namespace = "AWS/EC2"<br>    period    = "60"<br>    statistic = "Average"<br>    # CPU Utilization threshold is set to 10 percent<br>    threshold         = "70"<br>    alarm\_actions = null<br>    actions\_enabled = null<br>    insufficient\_data\_actions = null<br>    ok\_actions = null<br>    dimensions = {<br>        InstanceId = "i-082cb76ca0e5b43a7"   OR<br>        AutoScalingGroupName = "casper-aws-autoscaling"<br>    }<br>}<br>}))<br>Required configuration for attach rule to Sg | `any` | `null` | no |
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | The descriptive name for the alarm. | `string` | `""` | no |
| <a name="input_com_actions_enabled"></a> [com\_actions\_enabled](#input\_com\_actions\_enabled) | (Optional, Forces new resource) Indicates whether actions should be executed during any changes to the alarm state of the composite alarm. Defaults to true. | `bool` | `true` | no |
| <a name="input_com_alarm_actions"></a> [com\_alarm\_actions](#input\_com\_alarm\_actions) | (Optional) The set of actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed. | `list(any)` | `[]` | no |
| <a name="input_com_alarm_description"></a> [com\_alarm\_description](#input\_com\_alarm\_description) | (Optional) The description for the composite alarm. | `string` | `null` | no |
| <a name="input_com_alarm_name"></a> [com\_alarm\_name](#input\_com\_alarm\_name) | (Required) The name for the composite alarm. This name must be unique within the region. | `string` | n/a | yes |
| <a name="input_com_alarm_rule"></a> [com\_alarm\_rule](#input\_com\_alarm\_rule) | (Required) An expression that specifies which other alarms are to be evaluated to determine this composite alarm's state. For syntax, see Creating a Composite Alarm. The maximum length is 10240 characters. | `string` | n/a | yes |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | The arithmetic operation to use when comparing the specified Statistic and Threshold. | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_create_composite_alarm"></a> [create\_composite\_alarm](#input\_create\_composite\_alarm) | Create alarm composite. | `bool` | `false` | no |
| <a name="input_create_dashboard"></a> [create\_dashboard](#input\_create\_dashboard) | if true, enable create cloudwatch dashboard | `bool` | `false` | no |
| <a name="input_create_log_group"></a> [create\_log\_group](#input\_create\_log\_group) | if true, enable create canary test | `bool` | `false` | no |
| <a name="input_create_metric_alarm_expression"></a> [create\_metric\_alarm\_expression](#input\_create\_metric\_alarm\_expression) | Enable alarm with expression. | `bool` | `false` | no |
| <a name="input_create_syn_canary"></a> [create\_syn\_canary](#input\_create\_syn\_canary) | if true, enable create canary test | `bool` | `false` | no |
| <a name="input_dashboard_body"></a> [dashboard\_body](#input\_dashboard\_body) | (Required) The detailed information about the dashboard, including what widgets are included and their location on the dashboard. You can read more about the body structure in the documentation. | `string` | n/a | yes |
| <a name="input_dashboard_name"></a> [dashboard\_name](#input\_dashboard\_name) | (Required) The name of the dashboard. | `string` | n/a | yes |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | Dimensions for metrics. | `map` | `{}` | no |
| <a name="input_enabled_basic"></a> [enabled\_basic](#input\_enabled\_basic) | Create a specific alarm, if true. | `bool` | `false` | no |
| <a name="input_enabled_dynamic"></a> [enabled\_dynamic](#input\_enabled\_dynamic) | Creates a list of alarms, if true, consider the alarm\_list variable. | `bool` | `false` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold. | `number` | `"60"` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | The instance ID. | `string` | `""` | no |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input\_insufficient\_data\_actions) | The list of actions to execute when this alarm transitions into an INSUFFICIENT\_DATA state from any other state. | `list(any)` | `[]` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Name to be used on Log Group created. | `string` | `null` | no |
| <a name="input_log_stream_name"></a> [log\_stream\_name](#input\_log\_stream\_name) | Name to be used on Log Stream created. | `string` | `null` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The name for the alarm's associated metric. | `string` | `"CPUUtilization"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace for the alarm's associated metric. | `string` | `"AWS/EC2"` | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | The list of actions to execute when this alarm transitions into an OK state from any other state. | `list(any)` | `[]` | no |
| <a name="input_period"></a> [period](#input\_period) | The period in seconds over which the specified statistic is applied. | `number` | `120` | no |
| <a name="input_query_expressions"></a> [query\_expressions](#input\_query\_expressions) | values for metric query expression. | `any` | <pre>[<br>  {<br>    "expression": "ANOMALY_DETECTION_BAND(m1)",<br>    "id": "e1",<br>    "label": "CPUUtilization (Expected)",<br>    "return_data": "true"<br>  }<br>]</pre> | no |
| <a name="input_query_metrics"></a> [query\_metrics](#input\_query\_metrics) | values for metric query metrics. | `any` | <pre>[<br>  {<br>    "dimensions": {<br>      "InstanceId": "i-abc123"<br>    },<br>    "id": "m1",<br>    "metric_name": "CPUUtilization",<br>    "namespace": "AWS/EC2",<br>    "period": "120",<br>    "return_data": "true",<br>    "stat": "Average",<br>    "unit": "Count"<br>  }<br>]</pre> | no |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Days to keep data saved. | `number` | `3` | no |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | The statistic to apply to the alarm's associated metric. | `string` | `"Average"` | no |
| <a name="input_syn_canary_name"></a> [syn\_canary\_name](#input\_syn\_canary\_name) | Name to be used on Canary Test created. | `string` | `null` | no |
| <a name="input_syn_delete_lambda"></a> [syn\_delete\_lambda](#input\_syn\_delete\_lambda) | (Optional) Specifies whether to also delete the Lambda functions and layers used by this canary. The default is false | `bool` | `false` | no |
| <a name="input_syn_handler"></a> [syn\_handler](#input\_syn\_handler) | (Required) Entry point to use for the source code when running the canary. This value must end with the string .handler | `string` | n/a | yes |
| <a name="input_syn_rc_active_tracing"></a> [syn\_rc\_active\_tracing](#input\_syn\_rc\_active\_tracing) | (Optional) Whether this canary is to use active AWS X-Ray tracing when it runs. You can enable active tracing only for canaries that use version syn-nodejs-2.0 or later for their canary runtime. | `bool` | `false` | no |
| <a name="input_syn_rc_environment_variables"></a> [syn\_rc\_environment\_variables](#input\_syn\_rc\_environment\_variables) | (Optional) Map of environment variables that are accessible from the canary during execution. Please see AWS Docs for variables reserved for Lambda. | `map(any)` | `null` | no |
| <a name="input_syn_rc_memory_in_mb"></a> [syn\_rc\_memory\_in\_mb](#input\_syn\_rc\_memory\_in\_mb) | (Optional) Maximum amount of memory available to the canary while it is running, in MB. The value you specify must be a multiple of 64. | `string` | `null` | no |
| <a name="input_syn_rc_timeout_in_seconds"></a> [syn\_rc\_timeout\_in\_seconds](#input\_syn\_rc\_timeout\_in\_seconds) | (Optional) Number of seconds the canary is allowed to run before it must stop. If you omit this field, the frequency of the canary is used, up to a maximum of 840 (14 minutes). | `number` | `60` | no |
| <a name="input_syn_role_arn"></a> [syn\_role\_arn](#input\_syn\_role\_arn) | Role ARN for S3 and Canary Connection | `string` | `null` | no |
| <a name="input_syn_runtime_version"></a> [syn\_runtime\_version](#input\_syn\_runtime\_version) | (Required) Runtime version to use for the canary. Versions change often so consult the Amazon CloudWatch documentation for the latest valid versions. Values include syn-python-selenium-1.0, syn-nodejs-puppeteer-3.0, syn-nodejs-2.2, syn-nodejs-2.1, syn-nodejs-2.0, and syn-1.0. | `string` | n/a | yes |
| <a name="input_syn_s3_canary_bucket_name"></a> [syn\_s3\_canary\_bucket\_name](#input\_syn\_s3\_canary\_bucket\_name) | (Required) Location in Amazon S3 where Synthetics stores artifacts from the test runs of this canary. | `string` | n/a | yes |
| <a name="input_syn_s3_canary_file_bucket_name"></a> [syn\_s3\_canary\_file\_bucket\_name](#input\_syn\_s3\_canary\_file\_bucket\_name) | (Optional) Full bucket name which is used if your canary script is located in S3. The bucket must already exist. Specify the full bucket name including s3:// as the start of the bucket name. Conflicts with zip\_file - Name to be used on Id bucket for read the code in Zip file. | `string` | `null` | no |
| <a name="input_syn_s3_key_file"></a> [syn\_s3\_key\_file](#input\_syn\_s3\_key\_file) | S3 key of your script. Conflicts with zip\_file. canary\_zip\_inline.zip | `string` | `null` | no |
| <a name="input_syn_s3_version"></a> [syn\_s3\_version](#input\_syn\_s3\_version) | (Optional) S3 version ID of your script. Conflicts with zip\_file. | `string` | `null` | no |
| <a name="input_syn_sch_duration_in_seconds"></a> [syn\_sch\_duration\_in\_seconds](#input\_syn\_sch\_duration\_in\_seconds) | (Optional) Duration in seconds, for the canary to continue making regular runs according to the schedule in the Expression value. | `number` | `null` | no |
| <a name="input_syn_sch_expression"></a> [syn\_sch\_expression](#input\_syn\_sch\_expression) | (Required) Rate expression or cron expression that defines how often the canary is to run. | `number` | n/a | yes |
| <a name="input_syn_start_canary"></a> [syn\_start\_canary](#input\_syn\_start\_canary) | (Optional) Whether to run or stop the canary. | `bool` | `false` | no |
| <a name="input_syn_success_retention_period"></a> [syn\_success\_retention\_period](#input\_syn\_success\_retention\_period) | (Optional) Number of days to retain data about successful runs of this canary. If you omit this field, the default of 31 days is used. The valid range is 1 to 455 days. | `number` | `3` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The value against which the specified statistic is compared. | `number` | `40` | no |
| <a name="input_threshold_metric_id"></a> [threshold\_metric\_id](#input\_threshold\_metric\_id) | If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY\_DETECTION\_BAND function. | `string` | `null` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | (Optional) Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing. | `string` | `"missing"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_metric_alarm_arn"></a> [cloudwatch\_metric\_alarm\_arn](#output\_cloudwatch\_metric\_alarm\_arn) | The ARN of the Cloudwatch metric alarm. |
| <a name="output_cloudwatch_metric_alarm_id"></a> [cloudwatch\_metric\_alarm\_id](#output\_cloudwatch\_metric\_alarm\_id) | The ID of the Cloudwatch metric alarm. |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | The Amazon Resource Name (ARN) specifying the log group. |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the log group. |
