# Match RUBY_VERSION to .ruby-version file
ARG RUBY_VERSION=3.0.4
FROM ruby:$RUBY_VERSION

ENV BUNDLER_VERSION=2.4.13

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential postgresql-client vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.4.13

# Rails app lives here
WORKDIR /backend

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_ENV="production"

# Install application gems
COPY backend/Gemfile backend/Gemfile.lock ./
RUN bundle check || bundle install

# Copy application code
COPY backend .

# Copy frontend code
COPY ../frontend/build/web ./public/flutter

COPY backend/entrypoint.sh .
