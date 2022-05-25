require 'rails_helper'

RSpec.describe ShippingPrice, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'attr bottom volume deve estar presente' do
        price = ShippingPrice.new(bottom_volume: '')
        price.valid?
        expect(price.errors.include? :bottom_volume).to eq true
      end

      it 'attr upper volume deve estar presente' do
        price = ShippingPrice.new(upper_volume: '')
        price.valid?
        expect(price.errors.include? :upper_volume).to eq true
      end

      it 'attr upper weight deve estar presente' do
        price = ShippingPrice.new(upper_weight: '')
        price.valid?
        expect(price.errors.include? :upper_weight).to eq true
      end

      it 'attr bottom weight deve estar presente' do
        price = ShippingPrice.new(bottom_weight: '')
        price.valid?
        expect(price.errors.include? :bottom_weight).to eq true
      end
      
      it 'attr price_per_km deve estar presente' do
        price = ShippingPrice.new(price_per_km: '')
        price.valid?
        expect(price.errors.include? :price_per_km).to eq true
      end

      it 'attr carrier deve estar presente' do
        price = ShippingPrice.new(carrier: nil)
        price.valid?
        expect(price.errors.include? :carrier).to eq true
      end
    end

    context 'comparison' do
      it 'attr bottom_volume deve ser maior que 0'  do
        price = ShippingPrice.new(bottom_volume: '-0.001')
        price2 = ShippingPrice.new(bottom_volume: '0')
        price.valid?
        price2.valid?
        
        expect(price.errors.include? :bottom_volume).to eq true
        expect(price2.errors.include? :bottom_volume).to eq true
      end

      it 'attr upper_volume deve ser maior que 0' do
        price = ShippingPrice.new(upper_volume: '-0.001')
        price2 = ShippingPrice.new(upper_volume: '0')
        price.valid?
        price2.valid?
        
        expect(price.errors.include? :upper_volume).to eq true
        expect(price2.errors.include? :upper_volume).to eq true
      end

      it 'attr upper_volume deve ser maior que bottom_volume' do
        price = ShippingPrice.new(bottom_volume: '0.025', upper_volume: '0.01')        
        price.valid?      
        
        expect(price.errors.include? :upper_volume).to eq true
        
      end

      it 'attr bottom_volume deve ser menor que upper_volume' do
        price = ShippingPrice.new(bottom_volume: '0.07', upper_volume: '0.01')       
        price.valid?      
        
        expect(price.errors.include? :bottom_volume).to eq true
      end

      it 'attr bottom_weight deve ser maior que zero' do
        price = ShippingPrice.new(bottom_weight: '-1.25')
        price2 = ShippingPrice.new(bottom_weight: '0') 
        price.valid?
        price2.valid?
        
        expect(price.errors.include? :bottom_weight).to eq true
        expect(price2.errors.include? :bottom_weight).to eq true
      end

      it 'attr upper_weight deve ser maior que zero' do
        price = ShippingPrice.new(upper_weight: '-1.25')
        price2 = ShippingPrice.new(upper_weight: '0') 
        price.valid?
        price2.valid?
        
        expect(price.errors.include? :upper_weight).to eq true
        expect(price2.errors.include? :upper_weight).to eq true
      end

      it 'attr bottom_weight deve ser menor que upper_weight' do
        price = ShippingPrice.new(bottom_weight: '0.75', upper_weight: '0.5')
        price.valid?
        expect(price.errors.include? :bottom_weight).to eq true
      end

      it 'attr upper_weight deve ser maior que bottom_weight' do
        price = ShippingPrice.new(bottom_weight: '0.75', upper_weight: '0.5')
        price.valid?
        expect(price.errors.include? :upper_weight).to eq true
      end

      it 'attr price_per_km deve ser maior que zero' do
        price = ShippingPrice.new(price_per_km: '-1.75')
        price2 = ShippingPrice.new(price_per_km: '0')
        
        price.valid?
        price2.valid?
        expect(price.errors.include? :price_per_km).to eq true
        expect(price2.errors.include? :price_per_km).to eq true
      end
    end  

    
  end
end
