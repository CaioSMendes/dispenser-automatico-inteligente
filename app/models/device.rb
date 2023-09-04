class Device < ApplicationRecord
    #validates :device, uniqueness: true
    belongs_to :user, optional: true
    belongs_to :seller, optional: true #Dava certo é so voltar

    has_many :device_sellers
    has_many :sellers, through: :device_sellers

    #def device_name
        # Lógica para obter o nome do dispositivo
        # Por exemplo, se o nome do dispositivo estiver armazenado no campo "device" do modelo, você pode retornar assim:
        #.device
   # end

end
