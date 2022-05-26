class DeliveryTime < ApplicationRecord
  validates :bottom_distance, :upper_distance, :working_days, presence: true
  validates :bottom_distance, comparison: { greater_than_or_equal_to: 0}
  validates :bottom_distance, comparison: { less_than: :upper_distance}
  validates :upper_distance, comparison: { greater_than: 0}
  validates :working_days, comparison: { greater_than: 0}

  belongs_to :carrier

  
  def distance_description
    self.bottom_distance.to_s + ' - ' + self.upper_distance.to_s
  end
end
