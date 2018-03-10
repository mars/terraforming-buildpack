provider "local" {
  version = "~> 1.1"
}

variable "favorite_sushi" {
  type        = "string"
  description = "describe your favorite sushi"
}

resource "local_file" "sushi" {
  content  = "${var.favorite_sushi}"
  filename = "${path.module}/favorite_sushi.txt"
}

output "favorite_sushi" {
  value = "${var.favorite_sushi}"
}
