knife[:availability_zone] = "#{ENV['EC2_AVAILABILITY_ZONE']}"
knife[:aws_access_key_id] = "#{ENV['AWS_ACCESS_KEY_ID']}"
knife[:aws_secret_access_key] = "#{ENV['AWS_SECRET_ACCESS_KEY']}"
knife[:region] = "#{ENV['EC2_REGION']}"