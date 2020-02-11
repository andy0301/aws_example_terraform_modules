###################
# create mysql db as backend data store
# By Andy Cai
###################

resource "aws_db_instance" "mysql_example" {
  identifier_prefix = "${var.db_cluster_name}-example1"
  engine            = var.db_engine
  allocated_storage = var.db_storage_size
  instance_class    = var.db_instance_type
  name              = var.db_name
  username          = var.db_admin_username

  password = var.db_password
}