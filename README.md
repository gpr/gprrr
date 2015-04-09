# GemTemplate

[![Build Status](https://travis-ci.org/gpr/gem_template.svg?branch=master)](https://travis-ci.org/gpr/gem_template)
[![Doc Status](http://inch-ci.org/github/gpr/gem_template.svg?branch=master)](http://inch-ci.org/github/gpr/gem_template)
[![Code Climate](https://codeclimate.com/github/gpr/gem_template/badges/gpa.svg)](https://codeclimate.com/github/gpr/gem_template)
[![Coverage Status](https://coveralls.io/repos/gpr/gem_template/badge.svg)](https://coveralls.io/r/gpr/gem_template)

Template GEM for my own usage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gem_template'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gem_template

## Usage

To create a new gem from the template:

1. Clone it `git clone -o template git@github.com:gpr/gem_template.git' <new_name>`
2. Run the script with the new gem name `cd <new_name>; ./bin/create_gem <new_name>`
3. Edit the README
4. Commit the change `git commit -a -m "<new_name> gem created"`
5. Add the new git repository `git remote add origin git@github.com:gpr/<new_name>.git'`
6. Push and set the upstream `git push --set-upstream origin master`

### Configuration

It is possible to configure @@gem_template@@ by creating the file `$HOME/.gem_template.yaml`. You can copy default
configuration `etc/config.yaml` from the gem repository.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Test

To launch the tests suite:

    $ rake spec

To launch the test suite with coverage:

    $ rake COVERAGE=1 spec
    $ $BROWSER coverage/index.html

### Documentation

Yard is based on RDoc with some improvements.

See:

* [Yard](https://github.com/lsegal/yard/wiki/GettingStarted)
* [RDoc](https://github.com/rdoc/rdoc)

To generate the documentation:

    $ rake yard
    $ $BROWSER doc/index.html

To dynamically preview the doc (automatically refreshed):

    $ yard server --reload

## Contributing

1. Fork it ( https://github.com/gpr/gem_template/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Rake Tasks

* `rake build    # Build gem_template-0.1.0.beta1.gem into the pkg directory`
* `rake install  # Build and install gem_template-<VERSION>.gem into system gems`
* `rake release  # Create tag v0.1.0.beta1 and build and push gem_template-<VERSION>.gem to Rubygems`
* `rake spec     # Run minitest spec test suite`
* `rake yard     # Generate YARD Documentation`
