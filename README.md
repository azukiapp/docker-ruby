[azukiapp/ruby](https://registry.hub.docker.com/u/azukiapp/ruby/)
================

Base docker image to run Ruby applications

- Git
- Ruby `2.2` (and `1.9`, `2.0`, `2.1`)
- RubyGems 2.3.0
- Bundler
- NodeJS
- MySQL Client
- PostgreSQL Client
- MongoDB
- ImageMagick

##azk
Example of using that image with the [azk](http://azk.io):

```
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  ruby21: {
    // Dependent systems
    depends: [],
    // More images:  http://images.azk.io
    image: { docker: "azukiapp/ruby" },
    // Steps to execute before running instances
    provision: [
      "bundle install --path /azk/bundler",
    ],
    workdir: "/azk/#{manifest.dir}",
    shell: "/bin/bash",
    command: "bundle exec rackup config.ru --port $HTTP_PORT",
    wait: {"retry": 20, "timeout": 1000},
    mounts: {
      '/azk/bundler': persistent("bundler"),
      '/azk/#{manifest.dir}': path("."),
    },
    scalable: {"default": 2},
    http: {
      // ruby21.
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    envs: {
      // set instances variables
      RUBY_ENV: "development",
      BUNDLE_APP_CONFIG: "/azk/bundler",
    },
  },
});

```
