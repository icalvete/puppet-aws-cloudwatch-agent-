define aws_cloudwatch_agent::register (

  $order           = '99',
  $datetime_format = '%b %d %H:%M:%S',
  $file            = $name,
  $duration        = 5000,
  $bucket          = undef
) {

  $content = "[$name]
datetime_format = ${datetime_format}
file = ${file}
buffer_duration = ${duration}
log_stream_name = {hostname}
initial_position = start_of_file
log_group_name = ${bucket}
"
  concat::fragment{ "aws_cloudwatch_agent_fragment_$name":
    target  => "${aws_cloudwatch_agent::params::aws_cloudwatch_agent_root_path}/${aws_cloudwatch_agent::params::aws_cloudwatch_agent_config_file}",
    order   => $order,
    content => $content
  }
}
