require 'httparty'
require 'twilio-ruby'

class SmsMessagesController < ApplicationController
  before_action :set_sms_message, only: %i[ show edit update destroy ]

  # GET /sms_messages or /sms_messages.json
  def index
    #@sms_messages = SmsMessage.all
    @sms_logs = SmsLog.all
    @sms_messages = SmsMessage.all
    @last_sms_message = @sms_messages.last
    #@sms_messages = SmsMessage.last
  end

  # GET /sms_messages/1 or /sms_messages/1.json
  def show
  end

  # GET /sms_messages/new
  def new
    @sms_message = SmsMessage.new
    #@sms_template = SmsTemplate.new
  end

  # GET /sms_messages/1/edit
  def edit
    #@sms_message = SmsMessage.find(params[:id])
  end


  # POST /sms_messages or /sms_messages.json
  def create
    @sms_message = SmsMessage.new(sms_message_params)

    respond_to do |format|
      if @sms_message.save
        format.html { redirect_to sms_messages_path(@sms_message), notice: "Sms message was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_messages/1 or /sms_messages/1.json
  def update
    respond_to do |format|
      if @sms_message.update(sms_message_params)
        format.html { redirect_to sms_messages_path(@sms_message), notice: "Sms message was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def logs_message
    @sms_logs = SmsLog.all
  end

  # DELETE /sms_messages/1 or /sms_messages/1.json
  def destroy
    @sms_message.destroy

    respond_to do |format|
      format.html { redirect_to sms_messages_url, notice: "Sms message was successfully destroyed." }
    end
  end

  def send_sms_twilio
    account_sid = 'ACcbd199f02e7c1e843cd953a16ac1e714'
    auth_token = '81ad8e628f8487a68a5d3b2131e149f9'
    client = Twilio::REST::Client.new(account_sid, auth_token)

    phone_numbers = fetch_phone_numbers_from_api
    if params[:cont].to_i == 80 && phone_numbers.any?
      phone_number = phone_numbers.first['phone']
      send_sms_to_phone(client, phone_number)
      #redirect_to sms_messages_path, notice: "SMS enviado automaticamente!"
      return
    else
      render json: { message: 'SMS nao enviado automaticamente.' }
      return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_message
      @sms_message = SmsMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sms_message_params
      params.require(:sms_message).permit(:smsbody)
    end

    def fetch_phone_numbers_from_api
      api_url = 'https://dispenser-smart-api-9ae096adb72b.herokuapp.com/esp8266s'
      headers = {
        'Authorization' => 'Bearer YOUR_API_TOKEN' # Se sua API necessita de um token de autenticação, adicione-o aqui
      }
      
      response = HTTParty.get(api_url, headers: headers)
      if response.success?
        response.parsed_response
      else
        []
      end
    end

    def send_sms_to_phone(client, phone_number)
      from = '15416128239' # Número de telefone fornecido pela Twilio
      puts "Conteúdo de @last_sms_message: #{@last_sms_message}"
      body = @last_sms_message = SmsMessage.last
      #body = @last_sms_message.smsbody # Corpo da mensagem SMS
      #body = "TESTE" # Corpo da mensagem SMS

      
      #to = '5561992488131' # Número de telefone do destinatário Luis RFID
      #to = '5561998058131'
      #to = '5561995762787' # Número de telefone do destinatário Caio
      #to = '5561993212899' #Caian
      #to = '5561991150833' #Ivanice
  
      message = client.messages.create(
        from: from,
        to: phone_number,
        body: body
      )
  
      # Salva o log da mensagem
      sms_log = SmsLog.create(
        from_number: message.from,
        to_number: message.to,
        body: message.body,
        sent_at: Time.now
      )
    rescue Twilio::REST::TwilioError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
end