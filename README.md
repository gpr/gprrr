# GemTemplate

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Test

To launch the tests suite:

    $ rake spec

To launch the test suite with coverage:

    $ rake COVERAGE=1 spec
    $ $BROWSER coverage/index.html

## Contributing

1. Fork it ( https://github.com/gpr/gem_template/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request