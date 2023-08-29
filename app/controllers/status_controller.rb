require 'net/http'
require 'json'

class StatusController < ApplicationController
    def index
        uri = URI('https://dispenser-smart-api-9ae096adb72b.herokuapp.com/esp8266s')
    
        begin
          response = Net::HTTP.get(uri)
          @results = JSON.parse(response)
          @results = Kaminari.paginate_array(@results).page(params[:page]).per(8) if @results.present?
        rescue JSON::ParserError => e
          @error_message = "Erro ao analisar o JSON da resposta: #{e.message}"
        rescue StandardError => e
          @error_message = "Ocorreu um erro durante a requisição: #{e.message}"
        end
    
        render :index
      end
end
