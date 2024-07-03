require 'justcall_ruby/base'
require 'justcall_ruby/version'

require 'justcall_ruby/api'
require 'justcall_ruby/call'
require 'justcall_ruby/client'
require 'justcall_ruby/error'
require 'justcall_ruby/response'
require 'justcall_ruby/sms'

module JustCall
  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield(config)
  end

  class Configuration
    attr_accessor :full_debug

    alias full_debug? full_debug

    def initialize
      @full_debug = false
    end
  end
end
