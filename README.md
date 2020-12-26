# SmsMisr
PLEASE NOTE THAT this integrates with SMS MISR API ONLY https://smsmisr.com/
Ruby GEM: https://rubygems.org/gems/sms_misr
This GEM is still under testing

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sms_misr'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sms_misr

## CREDENTIALS SETUP

add the following credentials into your ENV file

````ruby
SEND_SMS_ENABLED=<must be set to true to allow sending messages, set to false prevent sending any messages>
SMS_USERNAME=<user name for your sms misr account>
SMS_PASSWORD=<password for your sms misr account>
FIXED_OTP_SMS_TOKEN=<Fixed message token for OTP API>
FIXED_OTP_SMS_SIGNATURE=<Fixed message signature for OTP API>
````
## SMS API

to use the sms api: 
````ruby
handler = SmsMisr::Handler.new('010XXXXXXXX')
parsed_response = handler.send_message("message", "SENDER") ## Sender is the sender value of your sms misr account
## language is English by default, to specify arabic language use the following
parsed_response = handler.send_message("message", "SENDER", 2)
````

## OTP API
to use OTP API make sure FIXED_OTP_SMS_TOKEN & FIXED_OTP_SMS_SIGNATURE are set in your env file
````ruby
handler = SmsMisr::Handler.new('010XXXXXXXX')
parsed_response = handler.send_otp('123456')
````

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Future work
- convert sms misr api responses to readable message
- add backgrounding with sidekiq

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sms_misr.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
