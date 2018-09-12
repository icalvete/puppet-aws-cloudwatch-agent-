class aws_cloudwatch_agent::install {

  include wget

  wget::fetch { "download_awslogs-agent-setup":
    source      => "https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/${aws_cloudwatch_agent::params::awslogs_agent_setup}",
    destination => $aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path,
    timeout     => 0,
    verbose     => true,
  }

  wget::fetch { "download_AgentDependencies":
    source      => "https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/${aws_cloudwatch_agent::params::agent_dependencies}",
    destination => $aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path,
    timeout     => 0,
    verbose     => true,
    require => Wget::Fetch['download_awslogs-agent-setup'],
  }

  exec { 'extract_download_AgentDependencies':
    command => "/bin/tar xfz ${aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path}/${aws_cloudwatch_agent::params::agent_dependencies}",
    user    => 'root',
    unless  => "/usr/bin/test -d ${aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path}/AgentDependencies",
    require => Wget::Fetch['download_AgentDependencies']
  }

  file { 'aws_cloudwatch_agent_config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => "${aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path}/awslogs.conf",
    content => template("${module_name}/awslogs.conf.erb"),
  }

  exec { 'aws_cloudwatch_agent_install':
    command => "/usr/bin/python ${aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path}/awslogs-agent-setup.py -n --region eu-west-1 --dependency-path ${aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path}/AgentDependencies -c ${aws_cloudwatch_agent::params::aws_cloudwatch_agent_target_path}/awslogs.conf",
    user    => 'root',
    unless  => "/usr/bin/test -d ${aws_cloudwatch_agent::params::aws_cloudwatch_agent_root_path}/state",
    require => [File['aws_cloudwatch_agent_config'], Exec['extract_download_AgentDependencies']]
  }
}
