resource "aws_security_group" "rds-db-sg" {
	name = "db-security-group"
	vpc_id = "vpc-08f3eea99feedf17c"

	ingress {
		from_port = 3306
		to_port = 3306
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_db_instance" "db" {
	allocated_storage 			= 20
	engine 					= "mysql"
	engine_version 				= "8.0"
	instance_class 				= "db.t3.micro"
	db_name 				= "phonebook_app_db"
	username 				= "admin"
	password 				= "12345678"
	port 					= "3306"
	vpc_security_group_ids 			= [aws_security_group.rds-db-sg.id]
	publicly_accessible 			= false
	allow_major_version_upgrade 		= false
	auto_minor_version_upgrade  		= false
	apply_immediately 			= true
	storage_encrypted 			= false
}
