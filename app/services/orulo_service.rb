require 'net/http'
require 'uri'

class OruloService
  ServiceData = Struct.new(:name, :min_area, :max_area, :min_bedrooms, :max_bedrooms, :min_suites, 
    :max_suites, :min_parking, :max_parking, :min_bathrooms, :max_bathrooms, :price_per_private_square_meter,
    :description, :finality, :orulo_url, :developer, :address, :opportunity, :default_image ,keyword_init: true)

  attr_reader :data

  def initialize
    @data = ServiceData.new
  end

  def find
    response = call
    process_response(response)
  end

  private

  def call
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
  end

  def process_response(response)
    parse_company_data(response_as_object(response.body))
  end

  def parse_company_data(response)
    data.name = response["buildings"][1]["name"]
    data.min_area = response["buildings"][1]["min_area"]
    data.max_area = response["buildings"][1]["max_area"] 
    data.min_bedrooms = response["buildings"][1]["min_bedrooms"]
    data.max_bedrooms = response["buildings"][1]["max_bedrooms"]
    data.min_suites = response["buildings"][1]["min_suites"]
    data.max_suites = response["buildings"][1]["max_suites"]
    data.min_parking = response["buildings"][1]["min_parking"]
    data.max_parking = response["buildings"][1]["max_parking"]
    data.min_bathrooms = response["buildings"][1]["min_bathrooms"]
    data.max_bathrooms = response["buildings"][1]["max_bathrooms"]
    data.price_per_private_square_meter = response["buildings"][1]["price_per_private_square_meter"]
    data.description = response["buildings"][1]["description"]
    data.finality = response["buildings"][1]["finality"]
    data.orulo_url = response["buildings"][1]["orulo_url"]
    data.developer = response["buildings"][1]["developer"]["name"]
    data.address = response["buildings"][1]["address"]
    data.finality = response["buildings"][1]["finality"]
    data.opportunity = response["buildings"][1]["opportunity"]
    data.default_image = response["buildings"][1]["default_image"]
    data
  end

  def response_as_object(response)
    JSON.parse(response, object_class: OpenStruct)
  end
end
