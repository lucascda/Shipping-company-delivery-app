class CarriersController < ApplicationController
  
  
  def index
    @carriers = Carrier.all
  end

  def show
    @carrier = Carrier.find(params[:id])
  end
  
  def edit
    @carrier = Carrier.find(params[:id])
  end

  def update
    @carrier = Carrier.find(params[:id])
    
    carrier_params = params.require(:carrier).permit(:corporate_name,:brand_name,:registration_number,
       :email_domain, :adress, :city, :state, :country, :status)
      
    if @carrier.update(carrier_params)
      redirect_to carrier_path(@carrier.id), notice: 'Transportadora atualizada com sucesso.'      
    else
      flash[:notice] = 'Transportadora não foi atualizada'
      render 'edit'
    end
  end

  def new
    @carrier = Carrier.new
  end

  def create
    carrier_params = params.require(:carrier).permit(:corporate_name,:brand_name,:registration_number,
      :email_domain, :adress, :city, :state, :country, :status)
    @carrier = Carrier.new(carrier_params)
   
    if @carrier.save()
      redirect_to carriers_path, notice: 'Transportadora cadastrada com sucesso'      
    else
      flash.now[:notice] = 'Transportadora não foi cadastrada'
      render 'new'
    end
  end
end