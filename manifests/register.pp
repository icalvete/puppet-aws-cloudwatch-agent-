define aws_cloudwatch_agent::register (

  $order   = '99',
  $content = undef
) {

  concat::fragment{ "aws_cloudwatch_agent_fragment_$name":
    target  => "${aws_cloudwatch_agent::params::aws_cloudwatch_agent_root_path}/${aws_cloudwatch_agent::params::aws_cloudwatch_agent_config_file}",
    order   => $order,
    content => $content
  }
}
