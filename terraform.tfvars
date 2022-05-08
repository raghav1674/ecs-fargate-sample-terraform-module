vpc_id             = "vpc-875a93ec"
public_subnet_ids  = ["subnet-ab38cec0", "subnet-543a1d18", "subnet-9ed0bee5"]
name               = "demo"
environment        = "dev"
region             = "ap-south-1"
container_port     = 80
ecr_repository_url = "285917307744.dkr.ecr.ap-south-1.amazonaws.com/docker_nodejs_repo:0c0fc55c9c80ffd4ae109e0f539c4fc9e159f7b8"