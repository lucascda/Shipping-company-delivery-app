class ShippingPricesController < ApplicationController
  before_action :set_shipping_price, only: [:update,:edit]
  before_action :authenticate_user!
  def index
    @prices = ShippingPrice.where(carrier: current_user.carrier.id)
  end

  def new
    @price = ShippingPrice.new
  end

  def create
    carrier = current_user.carrier
    price_params = set_price_params
    price_params[:carrier] = carrier
    @price = ShippingPrice.new(price_params)
    if @price.save()
      redirect_to shipping_prices_path, notice: 'Preço de Entrega cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Preço de Entrega não pode ser cadastrado'
      render 'new'
    end
  end

  def edit    
    if @price.carrier.id != current_user.carrier.id
      redirect_to root_path, notice: 'Preço não encontrado'
    end
    
  end

  def update 
    
    if @price.update(set_price_params)
      redirect_to shipping_prices_path, notice: 'Preço atualizado com sucesso'
    else
      flash.now[:notice] = 'Preço não foi atualizado'
      render 'edit'
    end

  end

  private

  def set_shipping_price
    @price = ShippingPrice.find(params[:id])   
  end

  def set_price_params
    price_params = params.require(:shipping_price).permit(:bottom_volume, :upper_volume, :bottom_weight,
      :upper_weight, :price_per_km)
  end
  
end