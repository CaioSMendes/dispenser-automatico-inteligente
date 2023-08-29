class DeviceSeller < ApplicationRecord
  belongs_to :device
  belongs_to :seller
end
