class aws_cloudwatch_agent::config {

  concat { "${aws_cloudwatch_agent::params::aws_cloudwatch_agent_root_path}/${aws_cloudwatch_agent::params::aws_cloudwatch_agent_config_file}":
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
  }

  aws_cloudwatch_agent::register{'aws_cloudwatch_agent_main':
    order   => 01,
    content => template("${module_name}/awslogs.conf.erb"),
  }
}
