# Dependencies for building the WoL website.
#
# The site is built with Jekyll 4 and deployed by GitHub Actions
# (.github/workflows/site.yml), not by the legacy GitHub Pages builder.
# Build locally with:  bundle install && bundle exec jekyll serve

source "https://rubygems.org"

gem "jekyll", "~> 4.4"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-include-cache"
  gem "jekyll-optional-front-matter"
  gem "jekyll-remote-theme"
  gem "jekyll-sitemap"
end

# Gems unbundled from the Ruby stdlib in 3.4+, still required by Jekyll's
# dependency chain. Remove once upstream declares them itself.
gem "base64"
gem "bigdecimal"
gem "csv"
gem "logger"
gem "ostruct"

# Windows / JRuby timezone support
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
