require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'uniqueness' do
      it 'attr plate deve ser obrigatório' do
        vehicle = Vehicle.new(plate: '')
        vehicle.valid?
        expect(vehicle.errors.include? :plate).to be true
      end

      it 'attr model deve ser obrigatório' do
        vehicle = Vehicle.new(model: '')
        vehicle.valid?
        expect(vehicle.errors.include? :model).to be true
      end

      it 'attr brand_name deve ser obrigatório' do
        vehicle = Vehicle.new(brand_name: '')
        vehicle.valid?
        expect(vehicle.errors.include? :brand_name).to be true
        
      end

      it 'attr fab_yer deve ser obrigatório' do
        vehicle = Vehicle.new(fab_year: '')
        vehicle.valid?
        expect(vehicle.errors.include? :fab_year).to be true
      end

      it 'attr max_cap deve ser obrigatório' do
        vehicle = Vehicle.new(max_cap: '')
        vehicle.valid?
        expect(vehicle.errors.include? :max_cap).to be true
      end

      it 'attr carrier deve ser obrigatório' do
        vehicle = Vehicle.new(carrier: nil)
        vehicle.valid?
        expect(vehicle.errors.include? :model).to be true
      end
    end

    context 'length' do
      it 'attr fab_year deve ter 4 digitos' do
        vehicle = Vehicle.new(fab_year: '200')
        expect(vehicle.valid?).to eq false        
      end
    end
  end
 
end
