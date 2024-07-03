require 'net/http'

module JustCall
  module API
    ROOT_URL = 'https://api.justcall.io/v2'.freeze
    USER_AGENT = "JustCallRubyGem/#{JustCall::VERSION}".freeze

    def get_request(client, endpoint)
      request = Net::HTTP::Get.new(request_url(endpoint))

      set_request_headers(client, request)
      submit_request(request)
    end

    def post_request(client, endpoint, data = {})
      request = Net::HTTP::Post.new(request_url(endpoint))

      set_request_headers(client, request, 'application/json')
      submit_request(request, data)
    end

    def put_request(client, endpoint, data = {})
      request = Net::HTTP::Put.new(request_url(endpoint))

      set_request_headers(client, request, 'application/json')
      submit_request(request, data)
    end

    def delete_request(client, endpoint)
      request = Net::HTTP::Delete.new(request_url(endpoint))

      set_request_headers(client, request)
      submit_request(request)
    end

    private

    def submit_request(request, data = {})
      request.body = data.is_a?(Hash) ? data.to_json : data if data.any?

      process_request(request)
    end

    def process_request(request)
      uri = URI(request.path)
      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = true
      http.set_debug_output($stdout) if JustCall.config.full_debug?

      response = http.start { |h| h.request(request) }

      JustCall::Response.new(response)
    end

    def set_request_headers(client, request)
      request['Accept'] = 'application/json'
      request['Authorization'] = [client.api_key, client.api_secret].join(':')
      request['Content-Type'] = 'application/json'
      request['User-Agent'] = USER_AGENT
    end

    def request_url(endpoint)
      [ROOT_URL, endpoint].join('/')
    end

    def standardize_body_data(submitted_data, permitted_data_attrs)
      submitted_data = submitted_data.deep_transform_keys(&:to_sym)
      permitted_data = submitted_data.select! { |k, _| permitted_data_attrs.include?(k) } || submitted_data

      permitted_data.deep_transform_keys { |k| k.to_s.camelize(:lower) }
    end

    def convert_params_to_request_query(params)
      params&.map { |k, v| [k.to_s.camelize(:lower), v].join('=') }&.join('&')
    end
  end
end
