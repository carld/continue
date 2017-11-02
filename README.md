[![Build Status](https://travis-ci.org/carld/continue.svg?branch=master)](https://travis-ci.org/carld/continue)

# Continue

This gem was created to help with situations where a chain or pipeline of
commands are run. Where a command encounters an error it can prevent remaining commands from being run.

For example,

```ruby
  Continue::Run [
    Continue::Command() {|val| do_something_ok ? true : false },
    Continue::Command() {|val| do_something_else; true }
  ]
```

For a lower level interface, a lambda can be provided. By convention the lambda
requires three parameters, a proc to be called on success, a proc to be called
on error, and a value object that can be used for shared context between the
commands.

```ruby

  Continue::Run [
    ->(s,e,v) { do_the_first_thing ? s.call : e.call },
    ->(s,e,v) { do_the_second_thing ? s.call : e.call },
    ->(s,e,v) { do_the_third_thing ? s.call : e.call }
  ]

```

This may help replace nested if statement code that looks like,

```ruby
  if do_the_first_thing
    if do_the_second_thing
       if do_the_third_thing
         handle_success
       else
         handle_error
       end
    else
      handle_error
    end
  else
    handle_error
  end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'continue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install continue

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/carld/continue. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Continue project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/carld/continue/blob/master/CODE_OF_CONDUCT.md).
