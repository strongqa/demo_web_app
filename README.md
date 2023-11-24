# Simple demo web application

## Installation

```
bin/setup
bin/rails s
```

## Run development environment locally on docker

```
docker-compose build
docker-compose run --rm web rake db:create db:migrate db:seed
docker-compose up
```

## Run production environment locally on docker

```
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml up
```

Useful commands:

```
docker-compose -f docker-compose.production.yml exec web rake db:create db:migrate db:seed
docker-compose -f docker-compose.production.yml exec web rake assets:precompile
docker-compose -f docker-compose.production.yml stop
```

## DEMO SERVER

http://demoapp.strongqa.com

```
Default admin email: admin@strongqa.com
Default password: 1234567890
```

_Note_: all test data, except 3 test articles and 5 demo users are cleaning up every day at 00:00 UTC

## API

curl 'http://demoapp.strongqa.com/api/v1/articles' -H 'Authorization: Token token="97f85fa997125c758a67213c44e1c0543a603f3819b31456b9"'

## Contribution

[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/0)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/0)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/1)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/1)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/2)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/2)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/3)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/3)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/4)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/4)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/5)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/5)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/6)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/6)[![](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/images/7)](https://sourcerer.io/fame/romikoops/strongqa/demo_web_app/links/7)
