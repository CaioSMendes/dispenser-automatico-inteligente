class DosePricesController < ApplicationController
    def index
        @dose_prices = DosePrice.all
        @last_dose = @dose_prices.last
    end

    def new
        @dose_prices = DosePrice.new
    end
    

     # POST /sellers or /sellers.json
    def create
        @dose_prices = DosePrice.new(dose_price_params)

      respond_to do |format|
      if @seller.save
        format.html { redirecseller_urlt_to doses_path(@dose_prices), notice: "Dose was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

    
    def edit
        @dose_price = DosePrice.find(params[:id])
    end
    
    def update
        @dose_price = DosePrice.find(params[:id])
        if @dose_price.update(dose_price_params)
          redirect_to dose_prices_path, notice: 'Valor da Dose atualizado com sucesso.'
        else
          render :edit
        end
    end
    
    def destroy
        @dose_price = DosePrice.find(params[:id])
        @dose_price.destroy
        redirect_to dose_prices_path, notice: 'Valor da Dose excluído com sucesso.'
    end
    
    private

    def seller_params
        params.require(:seller).permit(:status, :nome, :cardRFID, :cargo, :contador, :email)
      end
    
    def dose_price_params
        params.require(:dose_price).permit(:price)
    end
end
