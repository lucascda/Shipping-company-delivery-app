class OrderServicesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @order_services = OrderService.all
  end

  def show
    @order_service = OrderService.find(params[:id])
  end

  def new
    @order_service = OrderService.new
    @suppliers = Carrier.where(status: 0)
  end

  def create
    order_params = params.require(:order_service).permit(:source_adress, :dest_adress, :weight, :volume,
                  :weight, :product_code, :carrier_id)
    @order_service = OrderService.new(order_params)
    
    if @order_service.save()
      redirect_to @order_service, notice: 'Ordem de Serviço cadastrada com sucesso'
    else
      @suppliers = Carrier.where(status: 0)
      flash.now[:alert] = 'Ordem de Serviço não pôde ser criada'
      render 'new'
    end
  end
end