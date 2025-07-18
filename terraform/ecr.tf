resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
akashverma@Akashs-MacBook-Air terraform % cat ecr.tf
resource "aws_ecr_repository" "akash_app_repo" {
  name = "akash-cloud-app"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "akash-cloud-app-repo"
  }
}
