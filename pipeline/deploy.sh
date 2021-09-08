#!/bin/sh

# export AWS_PROFILE=tc-main
STAGE="test"
PROJECT_NAME="tc"
RESOURCE_GROUP="pipeline"
STACK_NAME="${STAGE}-${PROJECT_NAME}-${RESOURCE_GROUP}"
BUCKET_NAME="${STACK_NAME}-artifacts"
REGION="ap-southeast-2"

# Source github config global variables
source ./github.config

STACK_OVERRIDES="\
  GitHubOAuthToken=${GITHUB_OAUTH_TOKEN}
  GitHubOwner=${GITHUB_OWNER}
  GitHubRepo=${GITHUB_REPO}
  GitHubBranch=${GITHUB_BRANCH} \
"

aws cloudformation deploy \
  --template-file codepipeline.yaml \
  --stack-name "${STACK_NAME}" \
  --parameter-overrides Stage=${STAGE} ProjectName=${PROJECT_NAME} ResourceGroup=${RESOURCE_GROUP} ${STACK_OVERRIDES} \
  --capabilities CAPABILITY_NAMED_IAM \
  --no-fail-on-empty-changeset
