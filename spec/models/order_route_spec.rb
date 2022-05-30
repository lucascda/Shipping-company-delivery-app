require 'rails_helper'

RSpec.describe OrderRoute, type: :model do
  describe '#valid?' do
    it 'attr date deve estar presente' do
      route = OrderRoute.new(date: '')
      route.valid?
      expect(route.errors.include? :date).to eq true
    end

    it 'attr time deve estar presente' do
      route = OrderRoute.new(time: '')
      route.valid?
      expect(route.errors.include? :time).to eq true
    end

    it 'attr coordinates deve estar presente' do
      route = OrderRoute.new(coordinates: '')
      route.valid?
      expect(route.errors.include? :coordinates).to eq true
    end

    it 'attr date não pode ser futura' do
      route = OrderRoute.new(date: 1.day.from_now)
      route.valid?
      expect(route.errors.include? :date).to eq true
      expect(route.errors[:date]).to include(' não deve ser futura')
    end
  end
end
