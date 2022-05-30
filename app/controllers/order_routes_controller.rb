class OrderRoutesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  def index
    @order_service = OrderService.find(params[:order_service_id])
    if current_user.carrier.id != @order_service.carrier.id
      redirect_to root_path, alert: 'Página não existe'
    end    
    @order_routes = OrderRoute.where(order_service: @order_service)
  end

  def new    
    @order_service = OrderService.find(params[:order_service_id])
    if current_user.carrier.id != @order_service.carrier.id
      redirect_to root_path, alert: 'Página não existe'
    end
    @order_route = OrderRoute.new
  end

  def create
    @order_service = OrderService.find(params[:order_service_id])    
    route_params = params.require(:order_route).permit(:time,:date,:coordinates)    
    @order_route = OrderRoute.new(route_params)
    @order_route.order_service = @order_service
    if @order_route.save()
      redirect_to order_service_order_routes_path(@order_service), notice: 'Rota atualizada com sucesso'
    else
      flash.now[:alert] = 'Atualização de rota não pôde ser realizada'
      render 'new'
    end
    
  end
  
end