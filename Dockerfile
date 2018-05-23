FROM ruby:2.5.1-alpine3.7
LABEL vendor="StrongQA"

RUN apk --update add build-base nodejs tzdata sqlite-dev libxslt-dev libxml2-dev imagemagick
# postgresql-dev postgresql-client

ENV INSTALL_PATH /demo_web_app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install --jobs 4 --binstubs --without test production

COPY . .
VOLUME ["$INSTALL_PATH/public"]
EXPOSE 3000
# Provide a Healthcheck for Docker risk mitigation
# HEALTHCHECK --interval=3600s --timeout=20s --retries=2 CMD curl http://localhost:3000 || exit 1
ENTRYPOINT ["bundle", "exec"]
CMD [ "rails", "server"]
