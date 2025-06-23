terraform {
  source = "git::https://${get_env("BITBUCKET_USERNAME")}:${get_env("BITBUCKET_TOKEN")}@bitbucket.org/is_corp/cloudalpha-aws-lambda.git//modules/lambda_core?ref=dev"
}

inputs = {
  create_role                        = true
  role_name                          = null
  role_tags                          = "{"
  role_maximum_session_duration      = 3600
  role_permissions_boundary          = null
  role_force_detach_policies         = true
  role_path                          = null
  role_description                   = null
  archive_file = {
    archive_file_1 = {
      source_file = "./python/lambda.py"
      output_path = "./python/lambda.zip"
    }
  }
  create                             = true
  lambda_functions = {
    function-1 = {
      function_name                                 = "lambda_apexon"
      description                                   = "test lambda function from s3 bucket"
      handler                                       = "lambda.lambda_handler"
      lambda_role                                   = "arn:aws:iam::<account-id>:role/lambdaRoleExecution12"
      runtime                                       = "python3.8"
      tracing_mode                                  = "Active"
      archive_file_key                              = "archive_file_1"
      create_current_version_allowed_triggers        = true
      create_unqualified_alias_allowed_triggers      = true
      allowed_triggers = {
        trigger_1 = {
          statement_id  = "AllowTrigger1"
          action        = "lambda:InvokeFunction"
          principal     = "s3.amazonaws.com"
          source_arn    = "arn:aws:s3:::bitreponf"
        }
        trigger_2 = {
          statement_id  = "AllowTrigger2"
          action        = "lambda:InvokeFunction"
          principal     = "events.amazonaws.com"
          source_arn    = "arn:aws:events:us-east-1:123456789012:rule/example-rule"
        }
      }
      create_function                                 = true
      create_async_event_config                       = true
      create_current_version_async_event_config       = true
      create_unqualified_alias_async_event_config     = true
      maximum_event_age_in_seconds                    = 300
      maximum_retry_attempts                          = 2
      destination_on_failure                          = "arn:aws:sns:us-east-1:123456789012:lambda-failure"
      destination_on_success                          = "arn:aws:sns:us-east-1:123456789012:lambda-success"
      recursive_loop                                  = "Allow"
      name                                            = {}
    }
    tags = {
      Name        = "lambda-cloudalpha-us-east-1-web"
      Environment = "prod"
      Application = "cloudalpha"
      Owner       = "devops-team"
      CostCenter  = "CC-1234"
      CreatedBy   = "terraform"
    }
  }
  lambda_role                              = null
  lambda_at_edge                           = false
  timeout                                  = 3
  snap_start                               = false
  publish                                  = false
  kms_key_arn                              = null
  dead_letter_target_arn                   = null
  vpc_subnet_ids                           = null
  vpc_security_group_ids                   = null
  file_system_arn                          = null
  file_system_local_mount_path             = null
  tags                                     = "{"
  lambda_functions_tags                    = "{"
  image_config_entry_point                 = []
  image_config_command                     = []
  image_config_working_directory           = null
  timeouts                                 = "{"
  create_layer                             = false
  lambda_layers                            = "{"
  create_lambda_function_url               = false
  lambda_function_url                      = "{"
  create_signing_config                    = false
  code_signing_config                      = "{"
  add_trigger_config                       = "{"
  create_add_trigger                       = false
  destination_on_failure                   = null
  destination_on_success                   = null
  create_async_event_config                = false
  create_current_version_async_event_config = true
  create_unqualified_alias_async_event_config = true
  maximum_event_age_in_seconds             = null
  maximum_retry_attempts                   = null
  create_function                          = true
  create_current_version_allowed_triggers  = true
  create_unqualified_alias_allowed_triggers = true
  allowed_triggers                         = "{"
  recursive_loop                           = "Allow"
  api_gateway = {
    name = "my_api"
    integration = {
      type   = "AWS_PROXY"
      target = "lambda_apexon"
    }
  }
}