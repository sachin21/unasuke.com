###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/404.html', layout: false
page '/500.html', layout: false

set :css_dir, 'stylesheets'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :directory_indexes
###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

activate :external_pipeline,
  name: :webpack,
  command: "npm run build#{build? ? '': ':watch'}",
  source: ".tmp/dest"

activate :s3_sync do |s3_sync|
  s3_sync.region                     = 'ap-northeast-1'
  s3_sync.after_build                = false
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404/index.html'
end
