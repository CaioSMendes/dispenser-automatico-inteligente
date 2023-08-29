Rails.application.routes.draw do
  get '/user_management', to: 'user_management#index', as: 'user_management'
  resources :sellers do
    member do
      post 'associate_seller', to: 'devices#associate_seller'
      delete 'dissociate_seller', to: 'devices#dissociate_seller'
    end
    get 'attach_devices'
    post 'save_attached_devices'
  end

  get 'home/index'
  get 'esp8266/index'
  root 'home#index'
  get '/status', to: 'status#index'
  resources :devicelogs, only: [:index]
  get 'associar_dispositivo_usuario', to: 'devices#associar_dispositivo_usuario'
  delete 'devices/:id/dissociate', to: 'devices#dissociate', as: 'dissociate_device'
  get '/devices/in_use', to: 'devices#in_use', as: 'devices_in_use'
  get '/devices/in_use_seller', to: 'devices#in_use_seller', as: 'devices_in_use_seller'

  resources :api_manager

  resources :dose_prices

  namespace :administrador do
    resources :users, only: [:index, :edit, :update, :destroy]
  end
  
  resources :devices do
    post 'associate_device_seller'
    post 'assign_device', on: :member
    post 'save_to_database', on: :collection
    post 'save_data', on: :collection
    post 'devices/fetch_and_save_data', to: 'devices#fetch_and_save_data', as: 'fetch_and_save_data_devices'
  end

  post 'devices/associate', to: 'devices#associate', as: 'associate_device'
  post 'devices/fetch_and_save_data', to: 'devices#fetch_and_save_data', as: 'fetch_and_save_data_devices'
  resources :devices, only: [:new, :create, :show, :destroy]
  


  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :admin, only: [:destroy]
  resources :users, only: [:index, :show, :destroy]
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
      #delete '/users/cancel', to: 'users/registrations#destroy', as: :cancel_user_registration
    end


  # Rotas para o Admin
  get 'admin/index', as: 'admin_index'

  # Rotas para o User
  get 'user/index', as: 'user_index'

  # Rotas para o Envio de SMS
  

  resources :sms_messages 
    post '/send_sms_twilio', to: 'sms_messages#send_sms_twilio'
    # Rotas para o Envio de Whatsapp
    post '/send_whatsapp_message_twilio', to: 'sms_messages#send_whatsapp_message_twilio'
    get '/logs_message', to: 'sms_messages#logs_message'



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
