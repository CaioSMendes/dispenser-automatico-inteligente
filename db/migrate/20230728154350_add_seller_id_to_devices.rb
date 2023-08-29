class AddSellerIdToDevices < ActiveRecord::Migration[7.0]
  def change
    add_reference :devices, :seller, foreign_key: true

    # Atualizar registros existentes para definir um valor padrão para seller_id
    Device.update_all(seller_id: 0) # ou qualquer outro valor que você desejar  
  end
end