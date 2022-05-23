class VehiclesController < ApplicationController
  before_action :authenticate_user!
  def index
    user = current_user
    @vehicles = Vehicle.where(carrier: user.carrier.id)
  end

  def new
    @vehicle = Vehicle.new
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.carrier.id != current_user.carrier.id
      redirect_to vehicles_path, notice: 'Erro: Página não existe'
    end
  end
  
  def create
    carrier = current_user.carrier
    params_vehicle = params.require(:vehicle).permit(:plate, :brand_name, :model, :fab_year, :max_cap)
    params_vehicle[:carrier] = carrier
    @vehicle = Vehicle.new(params_vehicle)
    
    if @vehicle.save()
      redirect_to @vehicle, notice: 'Veículo cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Veículo não pode ser cadastrado.'
      render 'new'
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.carrier.id != current_user.carrier.id
      redirect_to vehicles_path, notice: 'Erro: Página não existe'
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])    
    params_vehicle = params.require(:vehicle).permit(:plate, :brand_name, :model, :fab_year, :max_cap)    

    if @vehicle.update(params_vehicle)
      redirect_to @vehicle, notice: 'Edição de veículo confirmada'
    else
      flash.now[:notice] = 'Edição de veículo não pôde ser concluída'
      render 'edit'
    end
  end
end