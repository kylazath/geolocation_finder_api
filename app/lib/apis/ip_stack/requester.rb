require 'net/http'

module Apis::IpStack
  class Requester
    class RequestError < StandardError; end

    API_ADDRESS = "http://api.ipstack.com/"

    class << self
      def geolocation_for(identifiable_by)
        response = Net::HTTP.get(uri_with(identifiable_by))
        response = JSON.parse(response)
        verify(response)
        response.slice("latitude", "longitude")
      rescue
        raise RequestError
      end

      private

      def uri_with(path)
        uri = URI("#{API_ADDRESS}/#{path}")
        uri.query = URI.encode_www_form(access_key: Rails.application.credentials.ipstack.api_key)
        uri
      end

      def verify(response)
        raise RequestError if response.key?("error")
      end
    end
  end
end
