require_relative "../test_helper"

module JustCall
  class ClientTest < Minitest::Test
    def test_it_sets_api_key_and_api_secret_when_initialized
      api_key = '123'
      api_secret = '456'
      client = JustCall::Client.new(api_key: api_key, api_secret: api_secret)

      assert_equal api_key, client.api_key
      assert_equal api_secret, client.api_secret
    end

    def test_it_responds_to_call_and_returns_the_call_library
      client = JustCall::Client.new(api_key: '123', api_secret: '123')

      assert client.call.instance_of?(JustCall::Call)
    end

    def test_it_responds_to_sms_and_returns_the_sms_library
      client = JustCall::Client.new(api_key: '123', api_secret: '123')

      assert client.sms.instance_of?(JustCall::SMS)
    end
  end
end
