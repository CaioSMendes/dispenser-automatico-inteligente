class Seller < ApplicationRecord
    #has_and_belongs_to_many :devices #funciona basta voltar
    has_many :device_sellers
    has_many :devices, through: :device_sellers
end