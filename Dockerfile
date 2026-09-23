# syntax=docker/dockerfile:1

# Build the Jekyll site from the locked Gemfile, then check its internal links.
FROM ruby:3.4-bookworm AS build
WORKDIR /src
ENV JEKYLL_ENV=production
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4
COPY . .
RUN bundle exec jekyll build --config _config.yml,_config.docker.yml --destination /site \
 && ruby script/linkcheck.rb /site

# Serve the static output.
FROM nginxinc/nginx-unprivileged:1.29-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
