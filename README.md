# test-cp
A minimal CI/CD setup with AWS CodePipeline and CodeBuild. Runs new execution upon PR merges.

- Requires a file `pipeline/github.config`, with global variables 
`GITHUB_OWNER`, `GITHUB_OAUTH_TOKEN`, `GITHUB_REPO` and `GITHUB_BRANCH`.
- 

  - Change `pipeline/deploy.sh` script's environment variables.
  - Using aws-cli with an AWS_PROFILE configured, run ./deploy.sh in `pipeline/`.
  - `stack1` resources are deployed in build stage.
  - Add more custom/build stages in `pipeline/template.yaml`.