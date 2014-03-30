require "spec_helper"

describe WebhookValidations::Validator do
  class ModuleTester
    class Request
      def ip
        "192.30.252.41"
      end
    end
    include WebhookValidations

    def request
      Request.new
    end
  end

  context "instances methods" do
    it "makes methods available" do
      expect(ModuleTester.new).to be_valid_incoming_webhook_address
    end
  end

  context "verifies IPs" do
    it "returns production" do
      expect(WebhookValidations::Validator.new("127.0.0.1")).to_not be_valid
      expect(WebhookValidations::Validator.new("192.30.252.41")).to be_valid
      expect(WebhookValidations::Validator.new("192.30.252.46")).to be_valid
    end
  end
end
