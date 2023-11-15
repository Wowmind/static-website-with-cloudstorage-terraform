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


# create an http loadbalancer

resource "google_compute_backend_bucket" "website-backend-0" {
  name = "website-backend-0"
  bucket_name = google_storage_bucket.website.name
  
}

resource "google_compute_url_map" "website-backend-url-map0" {
  name = "website-backend-url-map0"
  default_service = google_compute_backend_bucket.website-backend-0.self_link
  host_rule {
    hosts = [ "*" ]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_backend_bucket.website-backend-0.self_link
  }
}

resource "google_compute_target_http_proxy" "website-proxy-00" {
  name = "website-proxy-00"
  url_map = google_compute_url_map.website-backend-url-map0.name
}

# Enable CDN for http load balancer

resource "google_compute_backend_service" "website-backend-service-0" {
  name = "website-backend-service-0"
  backend {
    group = google_compute_backend_bucket.website-backend-0.self_link
  }
  enable_cdn = true
}

resource "google_compute_global_forwarding_rule" "website-forward-rule-0" {
  name = "website-forward-rule-0"
  target = google_compute_target_http_proxy.website-proxy-00.self_link

  port_range = "80"
}