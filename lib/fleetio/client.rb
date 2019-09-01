module Fleetio
  class Client
    API_URL = "https://secure.fleetio.com/"

    Response = Struct.new(:body, :success, keyword_init: true) do
      def self.from_http(response)
        new(
          success: response.success?,
          body: response.body
        )
      end

      def success?
        success
      end
    end
    def self.vehicle_info_for(vin, http_client = Faraday)
      adapter = http_client.new(url: API_URL) do |conn|
        conn.token_auth(ENV.fetch("FLEETIO_API_TOKEN"))
        conn.request :json
        conn.response :json
        conn.adapter http_client.default_adapter
        conn
      end
      new(adapter: adapter).vehicles({vin: vin})
    end

    def initialize(adapter:)
      @adapter = adapter
    end

    def vehicles(attrs)
      query = attrs.map { |attr| "[#{attr[0]}]=#{attr[1]}" }
      Response.from_http(adapter.get("/api/v1/vehicles", query, headers))
    end

    private

    def headers
      {
        "Account-Token" => ENV.fetch("FLEETIO_ACCOUNT_TOKEN"),
      }
    end

    attr_reader :adapter
  end
end
