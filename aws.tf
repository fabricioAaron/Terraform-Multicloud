# Sufijo aleatorio para evitar conflictos con el nombre del bucket S3 (debe ser único globalmente)
resource "random_pet" "bucket_suffix" {
  length    = 2
  separator = "-"
}

# Bucket S3 Básico
resource "aws_s3_bucket" "portfolio_bucket" {
  bucket = "${var.project_name}-bucket-${random_pet.bucket_suffix.id}"

  tags = {
    Environment = "Portfolio-Basico"
    Project     = var.project_name
  }
}
