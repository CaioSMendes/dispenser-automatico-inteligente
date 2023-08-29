require 'httparty'

class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:assign_device]
    
    def index
      response = HTTParty.get('https://dispenser-smart-api-9ae096adb72b.herokuapp.com/esp8266s')
      if response.code == 200
        api_data_array = JSON.parse(response.body)
    
        # Pagina os dados da API usando Kaminari
        @api_data = Kaminari.paginate_array(api_data_array).page(params[:page]).per(10)
      else
        @api_data = []
      end
    
      @users = User.all
      @devices = Device.includes(:user)
    end
      
   
    def associate
      selected_device = params[:device]
      user_id = params["user_device_#{selected_device}"]
  
      # Additional parameters from JSON data
      status = params[:status]
      ipadrrs = params[:ipadrrs]
      cont = params[:cont]
      last_seen = params[:last_seen]
      padlock = params[:padlock]
  
      # Encontra o dispositivo existente ou cria um novo
      @device = Device.find_or_create_by(device: selected_device)
  
      # Define os atributos para associar o dispositivo ao usuário
      @device.user_id = user_id
      @device.status = status
      @device.ipadrrs = ipadrrs
      @device.cont = cont
      @device.last_seen = last_seen
      @device.padlock = padlock
  
      if @device.save
        redirect_to devices_in_use_path, notice: 'Dispositivo associado com sucesso!'
      else
        redirect_to devices_path, alert: 'Erro ao associar dispositivo ao usuário.'
      end
    end
    
    
    def dissociate
      device = Device.find(params[:id])
      device.user_id = nil
      device.save
    
      redirect_to devices_path, notice: 'Associação do dispositivo removida com sucesso!'
    end

    def in_use
      #@devices = Device.all.page(params[:page]).per(10)
      @devices = Device.includes(:user).where.not(user_id: nil)
    end

    def in_use_seller
      @devices = Device.all
      @sellers = Seller.all
      #@device = Device.find(params[:id])
    end

    def associate_seller
      @device = Device.find(params[:id])
      seller_id = params[:device][:seller_id]
      @seller = Seller.find(seller_id)
  
      if @device.update(seller_id: seller_id)
        render :show_seller, notice: "Dispositivo associado com sucesso!"
      else
        render :show, alert: "Erro ao associar o dispositivo ao vendedor."
      end
    end
  
    def dissociate_seller
      @device = Device.find(params[:id])
  
      if @device.update(seller_id: nil)
        redirect_to @device, notice: "Dispositivo desassociado com sucesso!"
      else
        render :show, alert: "Erro ao desassociar o dispositivo do vendedor."
      end
    end

    def show
        @device = Device.find(params[:id])
        @devices = @user.devices if @user.present? && @user.devices.present?
    end

    private

    def device_params
      params.require(:device).permit(:device, :status, :ipadrrs, :cont, :last_seen, :padlock)
    end

    def check_admin
      redirect_to root_path, alert: 'Você não tem permissão para acessar essa página.' unless current_user.admin?
    end
end