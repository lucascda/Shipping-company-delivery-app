class ShippingPrice < ApplicationRecord
  validates :bottom_volume, :upper_volume, :upper_weight, :bottom_weight, :price_per_km, presence: true
  validates :bottom_volume, :upper_volume, :bottom_weight, :upper_weight, comparison: {greater_than: 0}
  validates :price_per_km, comparison: {greater_than: 0}
  validates :upper_volume, comparison: {greater_than: :bottom_volume}
  validates :bottom_volume, comparison: {less_than: :upper_weight}
  validates :bottom_weight, comparison: {less_than: :upper_weight}
  validates :upper_weight, comparison: {greater_than: :bottom_weight}
  belongs_to :carrier

  
  def volume_description
    self.bottom_volume.to_s + ' - ' + self.upper_volume.to_s
  end

  def weight_description
    self.bottom_weight.to_s + ' a '  + self.upper_weight.to_s + ' kg'  
  end

  
  
  
end
