require 'lib/i18n_helpers'
require 'lib/i18n_title_helpers'
require 'lib/data_helpers'
require 'lib/format_helpers'
require 'lib/icon_helpers'

helpers I18nHelpers
helpers I18nTitleHelpers
helpers DataHelpers
helpers FormatHelpers
helpers IconHelpers

# Activate multi-language
activate :i18n, :mount_at_root => :en

activate :directory_indexes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :external_pipeline,
  name: :tailwindcss,
  command: "npx tailwindcss --postcss -i ./source/stylesheets/site.css -o ./source/stylesheets/tailwind.css #{ build? ? "--minify" : "--watch" }",
  source: "source/stylesheets",
  latency: 1

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Blog
activate :blog do |blog|
  blog.paginate = false
  blog.permalink = "blog/{year}-{month}-{day}-{title}.html"
  blog.sources = "blog/en/{year}-{month}-{day}-{title}.html"
  blog.default_extension = ".md"
  blog.tag_template = "blog/tag.html"
  blog.calendar_template = "blog/calendar.html"
end

configure :build do
  activate :images
end

# Copy Netlify's _redirects file on build
proxy "_redirects", "netlify-redirects", ignore: true
