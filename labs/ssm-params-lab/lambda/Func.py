import json
import os
import boto3

client = boto3.client("ssm")
env = os.environ["ENV"]
app_config_path = os.environ["APP_CONFIG_PATH"]
full_config_path = "/" + env + "/" + app_config_path


def lambda_handler(event, context):

    print("Config Path: " + full_config_path)

    param_details = client.get_parameters_by_path(
        Path=full_config_path, Recursive=True, WithDecryption=True
    )

    print(json.dumps(param_details, default=str))