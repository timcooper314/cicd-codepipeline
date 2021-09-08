#!/bin/sh
set -e

STAGE="test"
PROJECT_NAME="tc"
RESOURCE_GROUP="pipeline"
STACK_NAME="${STAGE}-${PROJECT_NAME}-${RESOURCE_GROUP}"
BUCKET_NAME="${STACK_NAME}-artifacts-store"
#SECURITY_GROUP_ID="sg-042fe4977cec8fce5"
#SUBNET_LIST="subnet-cf6b85a9"
REGION="ap-southeast-2"

echo "AWS SAM packaging..."
echo ${BUCKET_NAME}
sam package \
  --template-file ./stack1.yaml \
  --output-template-file stack1Deploy.yaml \
  --s3-bucket ${BUCKET_NAME} \
#  --s3-prefix "${STACK_NAME}"
echo "Build exit code = $?"
test "$?" -ne 0 && exit $? || echo "Build completed successfully"

echo "AWS SAM deploying..."
sam deploy \
  --template-file stack1Deploy.yaml \
  --stack-name "${STACK_NAME}" \
  --parameter-overrides Stage=${STAGE} ProjectName=${PROJECT_NAME} ResourceGroup=${RESOURCE_GROUP} \
  --s3-bucket "${BUCKET_NAME}" \
  --capabilities CAPABILITY_NAMED_IAM \
  --no-fail-on-empty-changeset
#  --s3-prefix "${STACK_NAME}" \
#  --tags Stage=${STAGE} ProjectName=${PROJECT_NAME} ResourceGroup=${RESOURCE_GROUP} \
#  --region ${REGION}
