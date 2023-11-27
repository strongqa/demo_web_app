FROM ruby:3.2.2-alpine
LABEL vendor="StrongQA"

RUN apk --update add build-base nodejs tzdata libxslt-dev libxml2-dev imagemagick postgresql-dev postgresql-client gcompat

ENV INSTALL_PATH /demo_web_app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

ADD /app/assets /assets

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install --jobs 4 --binstubs --without test development

ENV RAILS_ENV production
ENV RACK_ENV production
ENV SECRET_KEY_BASE pickasecuretoken
ENV DATABASE_URL=postgres://@localhost:5432/demo_web_app_production

COPY . .

RUN bundle exec rake assets:precompile

VOLUME ["$INSTALL_PATH/public"]
EXPOSE 3000
# Provide a Healthcheck for Docker risk mitigation
# HEALTHCHECK --interval=3600s --timeout=20s --retries=2 CMD curl http://localhost:3000 || exit 1

ENTRYPOINT ["bundle", "exec"]
CMD [ "rails", "server"]
