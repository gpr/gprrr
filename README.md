# Gprrr

GPR's Rails Resources.
 
This gem provides helpers, generators and templates that ease the usage of several standard rails gems:

 - 'pundit'
 - 'kaminari'
 - 'table_for'
 - 'best_in_place'

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gprrr', github: 'gpr/gprrr'
```

And then execute:

    $ bundle


## Usage

The helpers and templates are automatically included.

### best_in_place

Views automatically generates editable fields for tables. In order to enable best_in_place don't forget to enable it
in your `application.js` file:

```javascript
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap-sprockets
//= require best_in_place

$(document).ready(function() {
    $('.best_in_place').best_in_place();
    $('.best_in_place').bind("ajax:success", function() {
            $(this).closest('tr').effect('highlight');
            jQuery.getScript('/welcome/get_flash');
        }
    );


    $('.best_in_place').bind('ajax:error', function () {
        jQuery.getScript('/welcome/get_flash');
    });
});

```

Note: in this example we use a controller action to update the flash:

```erb
$("#flash").html(
        "<%= escape_javascript(render partial: 'flash', locals: {flash: @flash}) %>"
);

```

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

1. Fork it ( https://github.com/gpr/gprrr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Rake Tasks

* `rake build    # Build gprrr-0.1.0.beta1.gem into the pkg directory`
* `rake install  # Build and install gprrr-<VERSION>.gem into system gems`
* `rake release  # Create tag v0.1.0.beta1 and build and push gprrr-<VERSION>.gem to Rubygems`
* `rake spec     # Run minitest spec test suite`
* `rake yard     # Generate YARD Documentation`
