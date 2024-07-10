require 'justcall_ruby/api'

module JustCall
  class SMS < Base
    include JustCall::API

    LIST_ATTRS = {
      permitted: %i[
        page per_page sort order from_datetime to_datetime contact_number
        justcall_number sms_direction sms_content last_sms_id_fetched
      ].freeze,
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
      list: "texts?%s".freeze,
      fetch: "texts/%s".freeze,
      check_reply: "texts/checkreply".freeze,
      send: "texts/new".freeze,
    }.freeze

    def initialize(client:)
      @client = client
    end

    def list(params = {})
      params = standardize_body_data(submitted_attrs: params, permitted_attrs: LIST_ATTRS[:permitted])
      endpoint = ENDPOINTS[:list] % convert_params_to_request_query(params)

      get_request(client: @client, endpoint: endpoint)
    end

    def fetch(sms_id)
      endpoint = ENDPOINTS[:fetch] % sms_id

      get_request(client: @client, endpoint: endpoint)
    end

    def check_reply(params)
      requires!(params, *CHECK_REPLY_ATTRS[:required])

      endpoint = ENDPOINTS[:check_reply]
      params = standardize_body_data(submitted_attrs: params, permitted_attrs: CHECK_REPLY_ATTRS[:permitted])

      post_request(client: @client, endpoint: endpoint, data: params)
    end

    def send(params)
      requires!(params, *SEND_ATTRS[:required])

      endpoint = ENDPOINTS[:send]
      params = standardize_body_data(submitted_attrs: params, permitted_attrs: SEND_ATTRS[:permitted])

      post_request(client: @client, endpoint: endpoint, data: params)
    end
  end
end
