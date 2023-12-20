FROM ruby:3.2.2-alpine
LABEL vendor="StrongQA"

RUN apk --update add build-base nodejs tzdata libxslt-dev libxml2-dev imagemagick postgresql-dev postgresql-client gcompat

ENV INSTALL_PATH /demo_web_app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install --jobs 4 --binstubs --without test development

ENV DATABASE_URL=postgres://@localhost:5432/demo_web_app_production
ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES="true"
ENV SECRET_KEY_BASE pickasecuretoken
ENV AWS_ACCESS_KEY_ID xxx
ENV AWS_SECRET_ACCESS_KEY xxx

COPY . .

RUN bundle exec rake assets:precompile

VOLUME ["$INSTALL_PATH/public"]
EXPOSE 3000
# Provide a Healthcheck for Docker risk mitigation
# HEALTHCHECK --interval=3600s --timeout=20s --retries=2 CMD curl http://localhost:3000 || exit 1

ENTRYPOINT ["bundle", "exec"]
CMD [ "rails", "server"]
