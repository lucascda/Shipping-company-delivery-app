require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'attr bottom_distance deve estar presente' do
        delivery_time = DeliveryTime.new(bottom_distance: '')
        delivery_time.valid?
        expect(delivery_time.errors.include? :bottom_distance).to eq true
      end
  
      it 'attr upper_distance deve estar presente' do
        delivery_time = DeliveryTime.new(upper_distance: '')
        delivery_time.valid?
        expect(delivery_time.errors.include? :upper_distance).to eq true
  
      end

      it 'attr working_days deve estar presente' do
        delivery_time = DeliveryTime.new(working_days: '')
        delivery_time.valid?
        expect(delivery_time.errors.include? :working_days).to eq true
      end

      it 'attr carrier deve estar presente' do
        delivery_time = DeliveryTime.new(carrier: nil)
        delivery_time.valid?
        expect(delivery_time.errors.include? :carrier).to eq true
      end

    end

    context 'comparison' do
      it 'attr bottom_distance deve ser igual ou maior que zero' do
        delivery_time = DeliveryTime.new(bottom_distance: -1, upper_distance: 30)
        delivery_time2 = DeliveryTime.new(bottom_distance: 0, upper_distance: 30)
        delivery_time3 = DeliveryTime.new(bottom_distance: 3, upper_distance: 30)
        delivery_time.valid?
        delivery_time2.valid?
        delivery_time3.valid?
        
        expect(delivery_time.errors.include? :bottom_distance).to eq true
        expect(delivery_time2.errors.include? :bottom_distance).to eq false
        expect(delivery_time3.errors.include? :bottom_distance).to eq false
      end

      it 'attr upper_distance deve ser maior que zero' do
        delivery_time = DeliveryTime.new(upper_distance: -1)
        delivery_time2 = DeliveryTime.new(upper_distance: 0)
        delivery_time3 = DeliveryTime.new(upper_distance: 3)
        delivery_time.valid?
        delivery_time2.valid?
        delivery_time3.valid?

        expect(delivery_time.errors.include? :upper_distance).to eq true
        expect(delivery_time2.errors.include? :upper_distance).to eq true
        expect(delivery_time3.errors.include? :upper_distance).to eq false
      end

      it 'attr bottom_distance deve ser maior que upper_distance' do
        delivery_time = DeliveryTime.new(bottom_distance: 30, upper_distance: 10)
        delivery_time2 = DeliveryTime.new(bottom_distance: 30, upper_distance: 45 )
        
        delivery_time.valid?
        delivery_time2.valid?
        
        expect(delivery_time.errors.include? :bottom_distance).to eq true
        expect(delivery_time2.errors.include? :bottom_distance).to eq false
      end

      it 'attr working_days deve ser maior que zero' do
        delivery_time = DeliveryTime.new(working_days: -1)
        delivery_time2 = DeliveryTime.new(working_days: 0)
        delivery_time3 = DeliveryTime.new(working_days: 3)

        delivery_time.valid?
        delivery_time2.valid?
        delivery_time3.valid?

        expect(delivery_time.errors.include? :working_days).to eq true
        expect(delivery_time2.errors.include? :working_days).to eq true
        expect(delivery_time3.errors.include? :working_days).to eq false

      end
    end

  end
 
end
