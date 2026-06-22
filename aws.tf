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

# Bloquear acceso público al bucket S3
resource "aws_s3_bucket_public_access_block" "portfolio_bucket_pab" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Habilitar versionado en el bucket S3
resource "aws_s3_bucket_versioning" "portfolio_bucket_versioning" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
