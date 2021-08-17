#!/bin/bash

STAGE="test"
PROJECT_NAME="tc"
RESOURCE_GROUP="pipeline"
STACK_NAME="${STAGE}-${PROJECT_NAME}-${RESOURCE_GROUP}"
BUCKET_NAME="test-tc-pipeline-artifacts"

SECURITY_GROUP_ID="sg-042fe4977cec8fce5"
SUBNET_LIST="subnet-cf6b85a9"
#echo "Installing dependencies..."
#pip install awscli aws-sam-cli
#echo "Dependencies successfully installed!"

chmod 644 $(find . -type f)
chmod 755 $(find . -type d)

mkdir -p dist/

STACK_OVERRIDES="\
  SecurityGroupId=${SECURITY_GROUP_ID}
  Subnets=${SUBNET_LIST} \
"

echo "AWS SAM packaging..."
sam package \
  --template-file template.yaml \
  --s3-bucket ${BUCKET_NAME} \
  --output-template-file dist/packaged.yaml \
  --s3-prefix "${PROJECT_NAME}-${RESOURCE_GROUP}"

echo "AWS SAM deploying..."
sam deploy \
  --template-file dist/packaged.yaml \
  --stack-name ${STACK_NAME} \
  --parameter-overrides Stage=${STAGE} ProjectName=${PROJECT_NAME} ResourceGroup=${RESOURCE_GROUP} ${STACK_OVERRIDES} \
  --s3-bucket ${BUCKET_NAME} \
  --s3-prefix "${PROJECT_NAME}-${RESOURCE_GROUP}" \
  --capabilities CAPABILITY_NAMED_IAM \
  --no-fail-on-empty-changeset \
  --tags Stage=${STAGE} ProjectName=${PROJECT_NAME} ResourceGroup=${RESOURCE_GROUP}