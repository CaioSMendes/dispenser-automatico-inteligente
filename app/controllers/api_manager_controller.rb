# app/controllers/api_manager_controller.rb

require 'httparty'

class APIManagerController < ApplicationController
  API_BASE_URL = 'https://dispenser-smart-api-9ae096adb72b.herokuapp.com/esp8266s'.freeze

  def index
    @devices = fetch_devices_from_api
  end

  def new
    @device = {}
  end

  def create
    response = HTTParty.post(API_BASE_URL, body: device_params.to_json, headers: { 'Content-Type' => 'application/json' })

    if response.success?
      flash[:success] = 'Device created successfully!'
      redirect_to devices_path
    else
      flash[:error] = 'Failed to create the device.'
      render :new
    end
  end

  def edit
    @device = fetch_device_from_api(params[:id])
  end

  def update
    response = HTTParty.patch("#{API_BASE_URL}/#{params[:id]}", body: device_params.to_json, headers: { 'Content-Type' => 'application/json' })

    if response.success?
      flash[:success] = 'Device updated successfully!'
      redirect_to devices_path
    else
      flash[:error] = 'Failed to update the device.'
      render :edit
    end
  end

  def destroy
    response = HTTParty.delete("#{API_BASE_URL}/#{params[:id]}")

    if response.success?
      flash[:success] = 'Device deleted successfully!'
    else
      flash[:error] = 'Failed to delete the device.'
    end

    redirect_to devices_path
  end

  private

  def device_params
    params.require(:device).permit(:device, :status, :ipadrrs, :cont, :last_seen, :padlock, :owner, :phone, :fullmax)
  end

  def fetch_devices_from_api
    response = HTTParty.get(API_BASE_URL)
    response.success? ? response.parsed_response : []
  end

  def fetch_device_from_api(id)
    response = HTTParty.get("#{API_BASE_URL}/#{id}")
    response.success? ? response.parsed_response : {}
  end
end
