resource "aws_autoscaling_group" "rawat-jalan" {

  name     = "rawat-jalan"
  min_size = 1
  max_size = 8
  
  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
  target_group_arns   = [aws_lb_target_group.rawat-jalan.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.rawat-jalan.id
      }
      override {
        instance_type = "t2.nano"
      }
    }
  }
    // Tambahkan blok ini untuk membuat instance EC2 terhubung dengan RDS
  lifecycle {
    create_before_destroy = true
  }
   depends_on = [aws_launch_template.rawat-jalan]

     
}

resource "aws_autoscaling_policy" "rawat-jalan" {
  name                   = "rawat-jalan"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.rawat-jalan.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }

}


  # target_tracking_configuration {
  #   //Menggunakan rata-rata lalu lintas jaringan yang diterima oleh instans grup Auto Scaling sebagai metrik. Unit yang digunakan adalah bytes per detik.
  #   predefined_metric_specification {
  #     predefined_metric_type = "ASGAverageNetworkIn"
  #   }

  #   target_value = 0
  # }
  # target_tracking_configuration {
  #   //Menggunakan rata-rata lalu lintas jaringan yang dikirim oleh instans grup Auto Scaling sebagai metrik. Unit yang digunakan adalah bytes per detik.
  #   predefined_metric_specification {
  #     predefined_metric_type = "ASGAverageNetworkOut"
  #   }

  #   target_value = 0
  # }
  # target_tracking_configuration {
  #   //Menggunakan jumlah permintaan yang diterima oleh target grup Application Load Balancer (ALB) sebagai metrik.
  #   predefined_metric_specification {
  #     predefined_metric_type = "ALBRequestCountPerTarget"
  #   }

  #   target_value = 0
  # }
  # target_tracking_configuration {
  #   //Menggunakan rata-rata penggunaan CPU dari instance pembaca (reader) RDS sebagai metrik. Unit yang digunakan adalah persentase.
  #   predefined_metric_specification {
  #     predefined_metric_type = "RDSReaderAverageCPUUtilization"
  #   }

  #   target_value = 0
  # }
  # target_tracking_configuration {
  #   //Menggunakan rata-rata jumlah koneksi database dari instance pembaca (reader) RDS sebagai metrik.
  #   predefined_metric_specification {
  #     predefined_metric_type = "RDSReaderAverageDatabaseConnections"
  #   }

  #   target_value = 0
  # }
    
