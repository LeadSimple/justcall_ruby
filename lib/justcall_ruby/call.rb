require 'justcall_ruby/api'

module JustCall
  class Call < Base
    include JustCall::API

    LIST_ATTRS = {
      permitted: %i[
        fetch_queue_data fetch_iq_data page per_page sort order from_datetime to_datetime
        contact_number justcall_number agent_id ivr_digit call_direction call_type
      ].freeze,
    }.freeze

    FETCH_ATTRS = {
      permitted: %i[fetch_queue_data fetch_iq_data].freeze,
    }.freeze

    UPDATE_ATTRS = {
      permitted: %i[notes disposition_code rating].freeze,
    }.freeze

    CHECK_REPLY_ATTRS = {
      permitted: %i[contact_number justcall_number].freeze,
      required: %i[contact_number].freeze,
    }.freeze

    SEND_ATTRS = {
      permitted: %i[justcall_number body contact_number media_url restrict_once].freeze,
      required: %i[justcall_number body contact_number].freeze,
    }.freeze

    ENDPOINTS = {
      list: "calls?%s".freeze,
      fetch: "calls/%s?%s".freeze,
      update: "calls/%s".freeze,
      download_recording: "calls/%s/recording/download".freeze,
    }.freeze

    def initialize(client)
      @client = client
    end

    def list(params = {})
      params = standardize_body_data(params, LIST_ATTRS[:permitted])
      endpoint = ENDPOINTS[:list] % convert_params_to_request_query(params)

      get_request(@client, endpoint)
    end

    def fetch(call_id, params = {})
      params = standardize_body_data(params, FETCH_ATTRS[:permitted])
      endpoint = ENDPOINTS[:fetch] % [call_id, convert_params_to_request_query(params)] # rubocop:disable Style/FormatString

      get_request(@client, endpoint)
    end

    def update(call_id, params)
      endpoint = ENDPOINTS[:update] % call_id
      params = standardize_body_data(params, UPDATE_ATTRS[:permitted])

      put_request(@client, endpoint, params)
    end

    def download_recording(call_id)
      endpoint = ENDPOINTS[:download_recording] % call_id

      get_request(@client, endpoint)
    end
  end
end
