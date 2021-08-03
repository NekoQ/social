# Project

Social Media Lists

## Install

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.7.2`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv):

```shell
rbenv install 2.7.2
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Set the database credentials
This app is using postgresql, if it is not set up on your computer follow [this](shorturl.at/doJOV).

Set the user name and password for your database

See [config/database.yml], the default section, lines 23, 24.

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

![img](https://github.com/nekoq/social/blob/main/img.png?raw=true)
