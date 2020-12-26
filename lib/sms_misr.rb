require "sms_misr/version"

# This class is responsible for sending the sms for the whole app
#
## `send_message` uses sms misr SMS API which takes a longer time to receive the message
###########
## `send_otp` uses sms misr OTP API which has a pre-set message identified by `token` and `Msignature` fields
##  which is found on their website
###########

module SmsMisr
  class Error < StandardError; end
    include HTTParty
    base_uri 'https://smsmisr.com/api'
    attr_reader :options

    def initialize(phone_number)
      @options = {
        query:
        {
          username: username,
          password: password,
          mobile: phone_number,
        },
      }
    end

    def send_message(message, sender, language = 1)
      return unenabled_message unless send_sms_enabled?

      @options[:query].merge!(message_params(message, sender, language))
      result = self.class.post('/webapi', @options)
      result.parsed_response
    end

    def send_otp(otp)
      return unenabled_message unless send_sms_enabled?

      @options[:query].merge!(otp_params(otp))
      result = self.class.post('/vSMS', @options)
      result.parsed_response
    end

    private

    def message_params(message, sender, language)
      {
        language: language,
        sender: sender,
        message: message,
      }
    end

    def otp_params(otp)
      {
        code: otp,
        token: fixed_message_token,
        Msignature: fixed_message_signature,
      }
    end

    def username
      ENV.fetch('SMS_USERNAME')
    end

    def password
      ENV.fetch('SMS_PASSWORD')
    end

    def send_sms_enabled?
      ENV.fetch('SEND_SMS_ENABLED') == 'true'
    end

    def fixed_message_token
      ENV.fetch('FIXED_OTP_SMS_TOKEN')
    end

    def fixed_message_signature
      ENV.fetch('FIXED_OTP_SMS_SIGNATURE')
    end

    def unenabled_message
      { message: 'sending sms is not enabled' }
    end
end

