PROFILE = test
ENVIRONMENT = sbx
PREFIX = fortest
REGION = us-east-1
CodeStarARN = arn:aws:codestar-connections:us-east-1:123456:host/gitlabtist-ff372e2b

.PHONY: create_pipeline ## Creates a new code pipeline cloudformation stack in AWS
create_pipeline: 
		make create_update_pipeline STACK_NAME=$(PREFIX)-$(ENVIRONMENT)-codepipeline ACTION=create

.PHONY: update_pipeline ## Updates an existing code pipeline cloudformation stack in AWS
update_pipeline: 
		make create_update_pipeline STACK_NAME=$(PREFIX)-$(ENVIRONMENT)-codepipeline ACTION=update


.PHONY: create_update_pipeline ## Creates or updates the code pipeline cloudformation stack based on the action
create_update_pipeline: 
	aws cloudformation $(ACTION)-stack \
		--stack-name $(STACK_NAME) \
		--template-body file://./codepipeline-stack.yaml \
		--profile $(PROFILE) \
		--region $(REGION) \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameters \
			ParameterKey=Environment,ParameterValue=$(ENVIRONMENT) \
			ParameterKey=StackPrefix,ParameterValue=$(PREFIX) \
			ParameterKey=StackName,ParameterValue=$(STACK_NAME) \
			ParameterKey=CodeStarARN,ParameterValue=$(CodeStarARN) \
