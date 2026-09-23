# syntax=docker/dockerfile:1

# Build the Jekyll site with the same gem set GitHub Pages uses.
FROM ruby:3.3-bookworm AS build
WORKDIR /src
ENV BUNDLE_GEMFILE=/src/docker/Gemfile \
    JEKYLL_ENV=production \
    PAGES_REPO_NWO=jbk708/wol
COPY docker/Gemfile docker/Gemfile
RUN bundle install --jobs 4
COPY . .
RUN bundle exec jekyll build --config _config.yml,_config.docker.yml --destination /site

# Serve the static output.
FROM nginxinc/nginx-unprivileged:1.29-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
