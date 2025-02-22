output "instance_id" {
  value       = aws_instance.app_server.id
  description = "The ID of the EC2 instance."
}

output "public_ip" {
  value       = aws_instance.app_server.public_ip
  description = "The public IP address of the EC2 instance."
}

output "instance_state" {
  value       = aws_instance.app_server.state
  description = "The current state of the EC2 instance."
}

output "instance_tags" {
  value       = aws_instance.app_server.tags
  description = "The tags associated with the EC2 instance."
}

