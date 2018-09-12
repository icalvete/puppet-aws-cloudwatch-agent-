# Puppet manifest to install and configure aws cloudwatch agent

Puppet manifest to install and configure aws cloudwatch agent

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-aws_cloudwatch_agent.png)](http://travis-ci.org/icalvete/puppet-aws_cloudwatch_agent)

## Examples:

```puppet

$aws_cloudwatch_agent_bucket = 'whateverbucketyouwant'

class {'aws_cloudwatch_agent':
  bucket => $aws_cloudwatch_agent_bucket
}

aws_cloudwatch_agent::register{'/var/log/apache2/access.log':
   datetime_format => '%d/%b/%Y:%H:%M:%S',
   file            => /var/log/apache2/access.log
   duration        => 5000
   bucket          => $aws_cloudwatch_agent_bucket
}

```

By default the aws_cloudwatch_agent class create a file with...

```
[/var/log/syslog]
datetime_format = %b %d %H:%M:%S 
file = /var/log/syslog
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = end_of_file
log_group_name = whateverbucketyouwant
```

## Authors:
 
Israel Calvete Talavera <icalvete@gmail.com>
