# Create a file using the local provider and local_file resource to demonstrate file creation in Terraform.
# resource "local_file" "automatedfile" {
#   filename = "automationfile.txt"
#   content  = "This is an example file created by Terraform."
# }

# to create a file using local-exec provisioner instead of local_file resource so that we can have more control over the file creation process.
# resource "null_resource" "example" {
#   provisioner "local-exec" {
#     command = "echo 'This is a local-exec provisioner example.' > local_exec_output.txt"
#   }
# }