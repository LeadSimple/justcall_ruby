module JustCall
  class Response
    attr_reader :body, :response, :sucess

    def initialize(response)
      @response = response

      case @response
      when Net::HTTPUnauthorized
        raise JustCall::Error::NotAuthorized, @response.body
      when Net::HTTPNotFound
        raise JustCall::Error::NotFound, @response.body
      when Net::HTTPOK, Net::HTTPSuccess, Net::HTTPNoContent, Net::HTTPCreated
        @success = true
        body = (JSON.parse(@response.body) if @response.body.present?)
        @body =
          if body.is_a?(Hash)
            body.deep_symbolize_keys
          elsif body.is_a?(Array)
            body.map(&:deep_symbolize_keys)
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
      body[key]
    end

    def fetch(key)
      body.fetch(key)
    end

    def success?
      !!success
    end
  end
end
