# app/services/device_data.rb
class DeviceData
    include HTTParty
  
    def self.fetch_and_save_data
      response = HTTParty.get('https://dispenser-smart-api-a2db2b28d087.herokuapp.com/esp8266s')
      devices_data = JSON.parse(response.body)
  
      devices_data.each do |device_data|
        device = Device.find_or_initialize_by(device: device_data['device'])
        device.status = device_data['status']
        device.ipadrrs = device_data['ipadrrs']
        device.cont = device_data['cont']
        device.last_seen = device_data['last_seen']
        device.save
      end
    end
end
  