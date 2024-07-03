require 'justcall_ruby/api'
require 'justcall_ruby/call'
require 'justcall_ruby/sms'

module JustCall
  class Client
    include JustCall::API

    attr_reader :api_key, :api_secret

    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    def call
      @call ||= JustCall::Call.new(self)
    end

    def sms
      @sms ||= JustCall::SMS.new(self)
    end
  end
end
