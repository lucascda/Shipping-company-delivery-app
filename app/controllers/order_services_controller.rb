class OrderServicesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :new, :create]
  before_action :authenticate_user!, only: [:users_index, :users_show, :accepted_orders, :update]
  def index
    @order_services = OrderService.all
  end

  def users_index
    @carrier = current_user.carrier
    @order_services = OrderService.where(carrier_id: @carrier.id, accepted_status: :waiting)
  end

  def users_show
    @order_service = OrderService.find(params[:id])
    if current_user.carrier_id != @order_service.carrier_id
      redirect_to root_path, alert: 'Ordem de Serviço não pôde ser encontrada'
    end
  end

  def new_accepted
    if user_signed_in?
      @carrier = current_user.carrier
      @vehicles = Vehicle.where(carrier: @carrier )
      @order_service = OrderService.find(params[:id])
    end    
  end

  def update
    @order_service = OrderService.find(params[:id])
    order_params = params.require(:order_service).permit(:vehicle_id)
    if @order_service.done! && @order_service.approved!
      if @order_service.update(order_params)
        redirect_to users_show_order_service_path(@order_service), notice: 'Ordem de Serviço aceita'
      end      
    end     
    
  end

  def accepted_orders
    if user_signed_in?
      @carrier = current_user.carrier
    end
    @order_services = OrderService.where(carrier: @carrier, order_status: :approved)
  end

  def refused
    @order_service = OrderService.find(params[:id])
    if @order_service.done! &&  @order_service.refused!
      redirect_to users_index_order_services_path, notice: 'Ordem de Serviço recusada'
    end
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