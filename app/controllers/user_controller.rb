class UserController < ApplicationController

    def index
        @devices = current_user.devices
    end

    def dashboard
        # Obter os dados da API
        response = HTTParty.get('https://dispenser-smart-api-947773b37df2.herokuapp.com/esp8266s')
        data = JSON.parse(response.body)
      
        # Obter a quantidade total de IDs
      
        # Preparar os dados para o gráfico
        total_ids = data.count
        chart_data = data.map { |entry| [entry['created_at'], entry['cont']] }
        @total_ids = total_ids
        @chart_data_json = chart_data.to_json
      
      
        @devices = Device.all
        if @devices.any?
            @device_names = @devices.pluck(:device)
            @device_counts = @devices.pluck(:cont)
        else
            # Lida com a situação em que não há registros
            # Por exemplo, você pode definir valores padrão ou exibir uma mensagem
        end

        #VENDEDORES
        @user = current_user  # Suponha que você tenha o método current_user definido para obter o usuário atual
        @sellers = @user.sellers  # Isso buscará todos os vendedores associados ao usuário atual
        @sellers_count = @sellers.count
      
        @user = current_user  # Suponha que você tenha o método current_user definido para obter o usuário atual
        @devices = @user.devices  # Isso buscará todos os vendedores associados ao usuário atual
        @devices_count = @devices.count

        @seller_sales = Seller.group(:nome).sum(:contador)
        @seller_names = @seller_sales.keys
        @total_sales = @seller_sales.values
      
        @users = User.all
        @role_counts = @users.group(:role).count
      
        @users = User.where(role: 'user')
        @users_total = @users.count
      
        dose_price = DosePrice.first.price
        total_doses = data.sum { |entry| entry['cont'] }
      
        @total_price = total_doses * dose_price
        @results = data
    end
  
    def show
        @user = User.find(params[:id])
    end

end
