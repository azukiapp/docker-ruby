[azukiapp/ruby](http://images.azk.io/#/ruby)
==================

Base docker image to run **Ruby** applications in [`azk`](http://azk.io)

Versions (tags)
---

- [`latest`, `2`, `2.2`, `2.2.0`](https://github.com/azukiapp/docker-ruby/blob/master/2.2/Dockerfile)
- [`2.1`, `2.1.2`](https://github.com/azukiapp/docker-ruby/blob/master/2.1/Dockerfile)
- [`2.0`, `2.0.0`, `2.0.0-p598`](https://github.com/azukiapp/docker-ruby/blob/master/2.0/Dockerfile)
- [`1.9`, `1.9.3`, `1.9.3-p551`](https://github.com/azukiapp/docker-ruby/blob/master/1.9/Dockerfile)

Image content:
---

- Ubuntu 14.04
- Git
- VIM
- NodeJS
- NPM
- Ruby
- Bundle
- ImageMagick

Database:

- PostgreSQL client
- MySQL client
- MongoDB

### Usage with `azk`

Example of using that image with the [azk](http://azk.io):

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
      '/azk/#{manifest.dir}': {type: 'path', value: '.'},
      '/azk/bundler'        : {type: 'persistent', value: 'bundler'},
    },
    scalable: {"default": 2},
    http: {
      // my-app.dev.azk.io
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    envs: {
      // set instances variables
      RUBY_ENV : 'development',
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

Azuki Dockerfiles distributed under the [Apache License](https://github.com/azukiapp/dockerfiles/blob/master/LICENSE).
