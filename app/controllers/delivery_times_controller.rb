class DeliveryTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_delivery_time, only: [:edit, :update]
  def index
    @delivery_times = DeliveryTime.where(carrier: current_user.carrier)
  end
  
  def new
    @delivery_time = DeliveryTime.new
  end

  def create
    user_carrier_param = current_user.carrier
    create_params = delivery_time_params
    create_params[:carrier] = user_carrier_param
    @delivery_time = DeliveryTime.new(create_params)
    if @delivery_time.save()
      redirect_to delivery_times_path, notice: 'Prazo de Entrega criado com sucesso.'
    else      
      flash.now[:notice]  = 'Prazo de Entrega não pode ser criado'
      render 'new'
    end
    
  end

  def edit
    if @delivery_time.carrier.id != current_user.carrier.id
      redirect_to root_path, notice: 'Prazo de Entrega inexistente'
    end
    
  end

  def update
    update_params = delivery_time_params
    if @delivery_time.update(update_params)
      redirect_to delivery_times_path, notice: 'Prazo de Entrega alterado com sucesso'
    else
      flash.now[:alert] = 'Prazo de Entrega não pode ser alterado'
      render 'edit'
    end
  end

  private

  def delivery_time_params
    my_params = params.require(:delivery_time).permit(:bottom_distance, :upper_distance, :working_days)
  end

  def set_delivery_time
    @delivery_time = DeliveryTime.find(params[:id])
  end
end