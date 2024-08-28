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

# Copy application code
COPY . .

RUN bundle check || bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["ruby", "./bin/rails", "server"]
