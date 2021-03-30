output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = join("", aws_lambda_function.lambda.*.arn)
}

output "lambda_iam_role_arn" {
  description = "ARN of IAM role used by Lambda function"
  value       = module.iam_role.iam_role_arn
}

output "input_file_name" {
  description = "Source code location"
  value       = join("", data.archive_file.zip.*.source_file)
}

output "output_file_path" {
  description = "Output filepath location"
  value       = data.archive_file.zip.output_path
}

output "output_file_size" {
  description = "Output filepath size"
  value       = data.archive_file.zip.output_size
}

output "cloudwatch_lambda_permissions" {
  value = join("", aws_lambda_permission.cloudwatch.*.id)
}