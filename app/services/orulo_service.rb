require 'net/http'
require 'uri'

class OruloService

  def render
    orulo_api_url = Rails.application.credentials.orulo_api_url
    orulo_api_key = Rails.application.credentials.orulo_api_key
    uri = URI.parse(orulo_api_url)
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{orulo_api_key}"
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response = JSON.parse(response.body)
    response
  end
end
