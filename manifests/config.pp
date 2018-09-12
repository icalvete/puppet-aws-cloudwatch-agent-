class aws_cloudwatch_agent::config {

  concat { "${aws_cloudwatch_agent::params::aws_cloudwatch_agent_root_path}/${aws_cloudwatch_agent::params::aws_cloudwatch_agent_config_file}":
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
  }
  
  concat::fragment{ "aws_cloudwatch_agent_main0":
    target  => "${aws_cloudwatch_agent::params::aws_cloudwatch_agent_root_path}/${aws_cloudwatch_agent::params::aws_cloudwatch_agent_config_file}",
    order   => 00,
    content => template("${module_name}/awslogs.conf.erb")
  }

  aws_cloudwatch_agent::register{'aws_cloudwatch_agent_main1':
    order           => 01,
    datetime_format => '%b %d %H:%M:%S',
    file            => '/var/log/syslog',
    bucket          => $aws_cloudwatch_agent::bucket
  }
}
