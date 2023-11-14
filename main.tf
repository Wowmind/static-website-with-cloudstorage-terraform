# create a bucket for the website

resource "google_storage_bucket" "website" {
  name = "my-web-info-site"
  location = var.region
  force_destroy = true
  
  website {
    main_page_suffix = "index.html"
    not_found_page = "404.html"
  }
}


# upload the index.html to the bucket
resource "google_storage_bucket_object" "index-html" {
  name = "index-web-page-inf0"
  bucket = google_storage_bucket.website.name

  source = "C:/Users/Alien/AppData/Local/Google/Cloud SDK/static-site/index.html"
  content_type = "text/index_html"
}

# upload the 404.html to the bucket

resource "google_storage_bucket_object" "static-404-html" {
  name = "404"
  bucket = google_storage_bucket.website.name

  source = "C:/Users/Alien/AppData/Local/Google/Cloud SDK/static-site/404.html"
  content_type = "text/404_html"
}

# create a object publicly accessible
resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.website.name
  role = "roles/storage.objectViewer"

  members = [ "allUsers" ]
}

