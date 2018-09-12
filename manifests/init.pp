class aws_cloudwatch_agent (

    $region = 'eu-west-1',
    $bucket = undef

) inherits aws_cloudwatch_agent::params {

  anchor {'aws_cloudwatch_agent::begin':
    before => Class['aws_cloudwatch_agent::install']
  }
  class {'aws_cloudwatch_agent::install':
    require => Anchor['aws_cloudwatch_agent::begin']
  }
  class {'aws_cloudwatch_agent::config':
    require => Class['aws_cloudwatch_agent::install']
  }
  class {'aws_cloudwatch_agent::service':
    subscribe => Class['aws_cloudwatch_agent::config']
  }
  anchor {'aws_cloudwatch_agent::end':
    require => Class['aws_cloudwatch_agent::service']
  }
}
