class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: [:show, :edit, :update]
  def index
    user = current_user
    @vehicles = Vehicle.where(carrier: user.carrier.id)
  end

  def new
    @vehicle = Vehicle.new
  end

  def show
    
    if @vehicle.carrier.id != current_user.carrier.id
      redirect_to vehicles_path, notice: 'Erro: Página não existe'
    end
  end
  
  def create
    carrier = current_user.carrier
    v_params = vehicle_params
    v_params[:carrier] = carrier
    @vehicle = Vehicle.new(v_params)    
    if @vehicle.save()
      redirect_to @vehicle, notice: 'Veículo cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Veículo não pode ser cadastrado.'
      render 'new'
    end
  end

  def edit
    
    if @vehicle.carrier.id != current_user.carrier.id
      redirect_to vehicles_path, notice: 'Erro: Página não existe'
    end
  end

  def update       
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Edição de veículo confirmada'
    else
      flash.now[:notice] = 'Edição de veículo não pôde ser concluída'
      render 'edit'
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])     
  end

  def vehicle_params
    my_params = params.require(:vehicle).permit(:plate, :brand_name, :model, :fab_year, :max_cap)
  end
end