module "security_groups" {
  source         = "./modules/security_groups"
  name           = var.name
  vpc_id         = var.vpc_id
  environment    = var.environment
  container_port = var.container_port
}

module "alb" {
  source              = "./modules/alb"
  name                = var.name
  vpc_id              = var.vpc_id
  subnets             = var.public_subnet_ids
  environment         = var.environment
  alb_security_groups = [module.security_groups.alb]
  health_check_path   = var.health_check_path
}

module "ecs" {
  depends_on = [
    module.alb
  ]
  source                      = "./modules/ecs_fargate"
  name                        = var.name
  environment                 = var.environment
  region                      = var.region
  subnets                     = var.public_subnet_ids
  aws_alb_target_group_arn    = module.alb.aws_alb_target_group_arn
  ecs_service_security_groups = [module.security_groups.ecs_tasks]
  container_port              = var.container_port
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  service_desired_count       = var.service_desired_count
  container_image             = var.ecr_repository_url
  container_environment = [
    { name = "PORT", value = var.container_port }
  ]
}
