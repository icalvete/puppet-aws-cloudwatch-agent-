class aws_cloudwatch_agent::service {

  service { 'awslogs':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
  }
}
