RSpec.describe SmsMisr do
  context 'check version' do 
    it "has a version number" do
      expect(SmsMisr::VERSION).not_to be nil
    end
  end

  context 'when sending a message' do 
    before do
      allow(ENV).to receive(:fetch).with('SMS_USERNAME')
      allow(ENV).to receive(:fetch).with('SMS_PASSWORD')
      allow(ENV).to receive(:fetch).with('FIXED_OTP_SMS_TOKEN')
      allow(ENV).to receive(:fetch).with('FIXED_OTP_SMS_SIGNATURE')
    end
    context 'when sending a message while messaging is not enabled' do 
      before do
        allow(ENV).to receive(:fetch).with('SEND_SMS_ENABLED').and_return(false)
      end
      it "return correct error message" do
        handler = SmsMisr::Handler.new('01000000000')
        response = handler.send_message("message", "SENDER", 2)
        expect(response[:message]).to include('sending sms is not enabled')
      end
    end
  
    context 'when sending a message and messaging is enabled' do 
      before do
        allow(ENV).to receive(:fetch).with('SEND_SMS_ENABLED').and_return('true')
      end
      it "returns error code" do
        handler = SmsMisr::Handler.new('01000000000')
        response = handler.send_message("message", "SENDER", 2)
        expect(response['code']).to eq('1906')
      end
    end
  end

  context 'when sending OTP' do 
    before do
      allow(ENV).to receive(:fetch).with('SMS_USERNAME')
      allow(ENV).to receive(:fetch).with('SMS_PASSWORD')
      allow(ENV).to receive(:fetch).with('FIXED_OTP_SMS_TOKEN')
      allow(ENV).to receive(:fetch).with('FIXED_OTP_SMS_SIGNATURE')
    end
    context 'when sending a message while messaging is not enabled' do 
      before do
        allow(ENV).to receive(:fetch).with('SEND_SMS_ENABLED').and_return(false)
      end
      it "return correct error message" do
        handler = SmsMisr::Handler.new('01000000000')
        response = handler.send_otp("123456")
        expect(response[:message]).to include('sending sms is not enabled')
      end
    end
  
    context 'when sending a message and messaging is enabled' do 
      before do
        allow(ENV).to receive(:fetch).with('SEND_SMS_ENABLED').and_return('true')
      end
      it "returns error code" do
        handler = SmsMisr::Handler.new('01000000000')
        response = handler.send_otp("123456")
        expect(response['code']).to eq('4006')
      end
    end
  end
end
