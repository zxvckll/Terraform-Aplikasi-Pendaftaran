locals {
  db_host = split(":", aws_db_instance.rds.endpoint)[0]
}


resource "aws_launch_template" "rawat-jalan" {
  name                   = "rawat-jalan"
  image_id               = "ami-0a09287fb20b0c871"
  key_name               = "us-east-1"
  vpc_security_group_ids = [aws_security_group.rawat-jalan.id]

  depends_on = [aws_db_instance.rds]

  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    apt update
    
     cd /opt
     cd BE-RS_Medika_Utama
     npm install
    
    echo "DB_HOST=${local.db_host}" >> /opt/BE-RS_Medika_Utama/.env
    echo "DB_USER=${aws_db_instance.rds.username}" >> /opt/BE-RS_Medika_Utama/.env
    echo "DB_PASSWORD=${aws_db_instance.rds.password}" >> /opt/BE-RS_Medika_Utama/.env
    echo "DB_NAME=${aws_db_instance.rds.db_name}" >> /opt/BE-RS_Medika_Utama/.env
    
    
    systemctl enable my-app.service
    systemctl start my-app.service
    systemctl status my-app.service
    journalctl -u my-app -f --no-pager
    EOF
  )

}
