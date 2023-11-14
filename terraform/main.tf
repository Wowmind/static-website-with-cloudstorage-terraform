# create a bucket for the website

resource "google_storage_bucket" "website" {
  name = "website-static"
  location = var.region
  force_destroy = true
  
  website {
    main_page_suffix = "index.html"
    not_found_page = "404.html"
  }
}
# upload the index.html to the bucket
resource "google_storage_bucket_object" "index-html" {
  name = "index.html"
  bucket = google_storage_bucket.website.name

  source = "static-site/index.html"
  content_type = "text/index_html"
}

# upload the 404.html to the bucket

resource "google_storage_bucket_object" "static-404-html" {
  name = "404.html"
  bucket = google_storage_bucket.website.name

  source = "static-site/404.html"
  content_type = "text/index_html"
}

# create a object publicly accessible
resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.website.name
  role = "roles/storage.objectViewer"

  members = [ "allUsers" ]
}

