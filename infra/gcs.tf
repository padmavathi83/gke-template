 resource "google_storage_bucket" "terraform_state" {
   name          = var.tf_state_bucket_name
   location      = var.region
   force_destroy = false # Set to true only if you want to delete the bucket and all its contents

    uniform_bucket_level_access = true
    public_access_prevention    = "enforced"

      logging {
       log_bucket = "bnsf-logging-bucket325y"
      }

   versioning {
     enabled = true
   }

   lifecycle {
     prevent_destroy = true
   }
 }
