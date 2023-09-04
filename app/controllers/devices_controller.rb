require 'httparty'

class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:assign_device]
    
    def index
      response = HTTParty.get('https://dispenser-smart-api-947773b37df2.herokuapp.com/esp8266s')
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
      @devices = Device.includes(:user).where.not(user_id: nil)
      #@devices = Device.all
    end

    def userdevice
      #@devices = Device.all # ou lógica para obter os dispositivos desejados
      # Certifique-se de que o usuário está logado
      if user_signed_in?
          # Obtenha o usuário atual
          @user = current_user
          
          # Obtenha os dispositivos atrelados a este usuário
          @devices = @user.devices
        else
          # Caso o usuário não esteja logado, você pode redirecioná-lo ou fazer outra coisa
          redirect_to new_user_session_path
        end
        @sellers = current_user.sellers
    end

    def in_use_seller
      @devices = Device.all
      @sellers = Seller.all
      #@device = Device.find(params[:id])
    end

    def associate_seller
      @device = Device.find(params[:id])
      @seller = Seller.find(params[:device][:seller_id])
  
      # Verifique se já existe uma associação para evitar duplicatas
      unless @device.sellers.include?(@seller)
        @device.sellers << @seller
      end
      redirect_to managerseller_path, notice: 'Vendedor associado com sucesso.'  
    end
  
    def dissociate_seller
      @device = Device.find(params[:device_id])
      @seller = Seller.find(params[:seller_id])
  
      if @device.sellers.exists?(@seller)
        @device.sellers.delete(@seller)
        flash[:success] = 'Vendedor desassociado com sucesso.'
      else
        flash[:error] = 'Vendedor não está associado a este dispositivo.'
      end
  
      redirect_to devices_path
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