class aws_cloudwatch_agent::params {

  $aws_cloudwatch_agent_root_path   = '/var/awslogs/etc/'
  $aws_cloudwatch_agent_config_file = 'awslogs.conf'
  $aws_cloudwatch_agent_target_path = '/tmp/'
  $awslogs_agent_setup              = 'awslogs-agent-setup.py'
  $agent_dependencies               = 'AgentDependencies.tar.gz'
}
