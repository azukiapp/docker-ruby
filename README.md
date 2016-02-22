[azukiapp/ruby](http://images.azk.io/#/ruby)
==================

Base docker image to run **Ruby** applications in [`azk`](http://azk.io)

Versions (tags)
---

<versions>
- [`latest`, `2`, `2.2`, `2.2.3`](https://github.com/azukiapp/docker-ruby/blob/master/2.2/Dockerfile)
- [`2.2-TDD`](https://github.com/azukiapp/docker-ruby/blob/master/2.2-TDD/Dockerfile)
- [`2.2-node12`](https://github.com/azukiapp/docker-ruby/blob/master/2.2-node12/Dockerfile)
- [`2.2.2`](https://github.com/azukiapp/docker-ruby/blob/2.2.2/2.2/Dockerfile)
- [`2.2.0`](https://github.com/azukiapp/docker-ruby/blob/v2.2.0/2.2/Dockerfile)
- [`2.1`, `2.1.4`](https://github.com/azukiapp/docker-ruby/blob/master/2.1/Dockerfile)
- [`2.1.2`](https://github.com/azukiapp/docker-ruby/blob/v2.1.2/2.1/Dockerfile)
- [`2.0`, `2.0.0`, `2.0.0-p598`](https://github.com/azukiapp/docker-ruby/blob/master/2.0/Dockerfile)
- [`1.9`, `1.9.3`, `1.9.3-p551`](https://github.com/azukiapp/docker-ruby/blob/master/1.9/Dockerfile)
- [`1.8`, `1.8.7`, `1.8.7-p374`](https://github.com/azukiapp/docker-ruby/blob/master/1.8/Dockerfile)
</versions>

Image content:
---

- Ubuntu 14.04
- Git
- VIM
- NodeJS
- npm
- Ruby
- Bundle
- ImageMagick
- Webkit
- QT4
- PHANTOMJS

Database:

- PostgreSQL client
- MySQL client
- MongoDB
- SQLite3

### Usage with `azk`

Example of using this image with [azk](http://azk.io):

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  "my-app": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More images:  http://images.azk.io
    image: {"docker": "azukiapp/ruby"},
    // Steps to execute before running instances
    provision: [
      "bundle install --path /azk/bundler"//,
      // "rake db:create",
      // "rake db:migrate"
    ],
    workdir: "/azk/#{manifest.dir}",
    shell: "/bin/bash",
    command: "bundle exec rackup config.ru --pid /tmp/ruby.pid --port $HTTP_PORT --host 0.0.0.0",
    wait: {"retry": 20, "timeout": 1000},
    mounts  : {
      '/azk/#{manifest.dir}': path('.'),
      '/azk/bundler'        : persistent('bundler'),
    },
    scalable: {"default": 1},
    http: {
      // my-app.dev.azk.io
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    envs: {
      // set instances variables
      RACK_ENV : 'development',
      BUNDLE_APP_CONFIG : '/azk/bundler',
    }
  },
});
```

### Usage with `docker`

To create the image `azukiapp/ruby`, execute the following command on the docker-ruby folder:

```sh
$ docker build -t azukiapp/ruby 2.2/
```

To run the image and bind to port 3000:

```sh
$ docker run -it --rm --name my-app -p 3000:3000 -v "$PWD":/myapp -w /myapp azukiapp/ruby ruby app.rb
```

Logs
---

```sh
# with azk
$ azk logs my-app

# with docker
$ docker logs <CONTAINER_ID>
```

## License

Azuki Dockerfiles distributed under the [Apache License][license].

[license]: ./LICENSE

