terraform {
 backend "s3" {
	bucket = "statefiletfeast2"
	key = "s3:/statefiletfeast2/aws-s3-bucket-demo/statefile.tfstate"
	region = "us-east-2"
	encrypt = true
	profile = ""
	//dynamodb_table = "statefiletfeast2"
  }
}