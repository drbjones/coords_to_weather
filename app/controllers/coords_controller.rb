require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    # location = params[:location_lookup]
    if params[:location_lookup] == nil
        @address = "Chicago"
    else
        @address = params[:location_lookup]
    end
    @url_safe_address = URI.encode(@address)
    geolocate_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_address}&sensor=false"
    raw_data_geo = open(geolocate_url).read
    parsed_data_geo = JSON.parse(raw_data_geo)
    @latitude = parsed_data_geo["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data_geo["results"][0]["geometry"]["location"]["lng"]

    # @latitude = 33.50058
    # @longitude = -82.022054
    your_api_key = "c73c2a638a49346243436fc87853d52d"

    # Your code goes here.
    forecast_url = "https://api.forecast.io/forecast/#{your_api_key}/#{@latitude},#{@longitude}"
    raw_data_forecast = open(forecast_url).read
    parsed_data_forecast = JSON.parse(raw_data_forecast)
    @temperature = parsed_data_forecast["currently"]["temperature"]
    @minutely_summary = parsed_data_forecast["minutely"]["summary"]
    @hourly_summary = parsed_data_forecast["hourly"]["summary"]
    @daily_summary = parsed_data_forecast["daily"]["summary"]
  end
end
