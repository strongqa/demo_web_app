Simple demo web application
==========================

## Installation

```
bin/setup
bin/rails s
```

## Known issues

If **bundle install** raise the error:

```
`mri_21` is not a valid platform. The available options are: [:ruby, :ruby_18,
:ruby_19, :ruby_20, :mri, :mri_18, :mri_19, :mri_20, :rbx, :jruby, :mswin,
:mingw, :mingw_18, :mingw_19, :mingw_20]
```

Then update bundler:

```
gem update bundler
```


## DEMO SERVER

http://demoapp.strongqa.com

```
admin_email: admin@strongqa.com
admin_password: 1234567890

```

*Note*: all test data, except 3 test articles and 5 demo users are cleaning up every day at 00:00 UTC

##API

curl 'http://demoapp.strongqa.com/api/v1/articles' -H 'Authorization: Token token="97f85fa997125c758a67213c44e1c0543a603f3819b31456b9"'
