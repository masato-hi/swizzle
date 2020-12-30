
# Swizzle

swizzle is a gem for easy to do method swizzling to class methods, instance methods.

![test](https://github.com/masato-hi/swizzle/workflows/test/badge.svg)
![rubocop](https://github.com/masato-hi/swizzle/workflows/rubocop/badge.svg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swizzle'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install swizzle

## Usage

```ruby
# include Swizzle
class SwizzleKlass
  include Swizzle

  def self.klass_method
    "klass_method"
  end

  def self.swizzle_klass_method
    "swizzled_klass_method"
  end

  def instance_method
    "instance_method"
  end

  def swizzle_instance_method
    "swizzled_instance_method"
  end
end

# before method swizzling.
SwizzleKlass.klass_method #=> "klass_method"
SwizzleKlass.new.instance_method #=> "instance_method"

# do method swizzling.
SwizzleKlass.swizzle!

# after method swizzling.
SwizzleKlass.klass_method #=> "swizzled_klass_method"
SwizzleKlass.new.instance_method #=> "swizzled_instance_method"
```

## Example
```ruby
class CreditCardPaymentService
  include Swizzle

  def authorize!
    # payment request for production.
  end

  def swizzle_authorize!
    # return dummy response.
  end
end

CreditCardPaymentService.swizzle! unless Rails.env.production?

CreditCardPaymentService.authorize! #=> dummy response.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/masato-hi/swizzle.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
