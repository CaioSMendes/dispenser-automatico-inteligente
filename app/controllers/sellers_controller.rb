class SellersController < ApplicationController
  before_action :set_seller, only: %i[show edit update destroy attach_devices save_attached_devices]

  # GET /sellers or /sellers.json
  def index
    @sellers = Seller.all
    @devices = Device.all
    #@devices = Device.includes(:seller)
  end

  def associate_device_seller
    @device = Device.find(params[:id])
    seller_id = params[:device][:seller_id]
    @seller = Seller.find(seller_id)

    if @device.update(seller_id: seller_id)
      redirect_to @device, notice: "Device associated with seller successfully!"
    else
      render :show, alert: "Error associating the device with the seller."
    end
  end


  def attach_devices
    @seller = Seller.find(params[:id])
    @devices = Device.all
  end

  def save_attached_devices
    @seller = Seller.find(params[:id])
    selected_device_ids = params[:seller][:device_ids]

    # Limpa as associações atuais com os devices
    @seller.devices.clear

    # Associa os dispositivos selecionados ao seller
    if selected_device_ids.present?
      selected_device_ids.each do |device_id|
        device = Device.find(device_id)
        @seller.devices << device
      end
    end

    redirect_to sellers_path, notice: 'Devices atrelados com sucesso!'
  end

  # GET /sellers/1 or /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers or /sellers.json
  def create
    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        format.html { redirect_to seller_url(@seller), notice: "Seller was successfully created." }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1 or /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to seller_url(@seller), notice: "Seller was successfully updated." }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1 or /sellers/1.json
  def destroy
    @seller.destroy

    respond_to do |format|
      format.html { redirect_to sellers_url, notice: "Seller was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def associate_device
    @seller = Seller.find(params[:seller_id])
    @device = Device.find(params[:device_id])

    if @device.sellers << @seller
      redirect_to devices_path, notice: 'Vendedor associado com sucesso!'
    else
      redirect_to devices_path, alert: 'Erro ao associar vendedor ao dispositivo.'
    end
  end

  private

    # Define o filtro para carregar o @seller com base no ID fornecido na URL
    def set_seller
      @seller = Seller.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to sellers_path, alert: 'Seller não encontrado.'
    end


    # Only allow a list of trusted parameters through.
    def seller_params
      params.require(:seller).permit(:id, :status, :nome, :cardRFID, :cargo, :contador, :email)
    end
end
