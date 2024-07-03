module JustCall
  class Response
    attr_accessor :success

    def initialize(response)
      @response = response

      case @response
      when Net::HTTPUnauthorized
        raise JustCall::Error::NotAuthorized, @response.body
      when Net::HTTPNotFound
        raise JustCall::Error::NotFound, @response.body
      when Net::HTTPOK, Net::HTTPSuccess, Net::HTTPNoContent, Net::HTTPCreated
        self.success = true
        data = (JSON.parse(@response.body) if @response.body.present?)

        @data =
          if data.is_a?(Hash)
            data.deep_symbolize_keys
          elsif data.is_a?(Array)
            data.map(&:deep_symbolize_keys)
          end
      else
        puts "-- DEBUG: #{self}: RequestError: #{@response.inspect}" if JustCall.config.full_debug?

        error_message = begin
          JSON.parse(@response.body)['errors'].map { |error| error['message'].chomp('.') }.join('. ')
        rescue StandardError
          [@response.message, @response.body].reject(&:blank?).join(" | ")
        end

        raise JustCall::Error::RequestError, error_message
      end
    end

    def [](key)
      @data[key]
    end

    def body
      @data
    end

    def fetch(key)
      @data.fetch(key)
    end

    def success?
      !!success
    end
  end
end
