import boto3
import os
import mimetypes
# basically returns a list of a all files in the branch
def get_blob_list(codecommit, repository, branch):
    response = codecommit.get_differences(
        repositoryName=repository,
        afterCommitSpecifier=branch,
    )
    blob_list = [difference['afterBlob'] for difference in response['differences']]
    while 'nextToken' in response:
        response = codecommit.get_differences(
            repositoryName=repository,
            afterCommitSpecifier=branch,
            nextToken=response['nextToken']
        )
        blob_list += [difference['afterBlob'] for difference in response['differences']]
    return blob_list


# lambda-function
# triggered by changes in a codecommit repository
# reads files in the repository and uploads them to s3-bucket
#
# ENVIRONMENT VARIABLES:
#     s3BucketName
#     codecommitRegion
#     repository
#     branch
#
# TIME OUT: 1 min
#
# EXECUTION ROLE
#     AWSCodeCommitReadOnly
#     AWSLambdaExecute


def lambda_handler(event, context):
# target bucket
    bucket = boto3.resource('s3').Bucket(os.environ['s3BucketName'])
# source codecommit
    codecommit = boto3.client('codecommit', region_name=os.environ['codecommitRegion'])
    repository_name = os.environ['repository']
# reads each file in the branch and uploads it to the s3 bucket
    for blob in get_blob_list(codecommit, repository_name, os.environ['branch']):
        path = blob['path']
        content = (codecommit.get_blob(repositoryName=repository_name, blobId=blob['blobId']))['content']
# we have to guess the mime content-type of the files and provide it to S3 since S3 cannot do this on its own.
        content_type = mimetypes.guess_type(path)[0]
        if content_type is not None:
            bucket.put_object(Body=(content), Key=path, ContentType=content_type)
        else:
            bucket.put_object(Body=(content), Key=path)