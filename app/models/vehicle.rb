class Vehicle < ApplicationRecord
  validates :plate, :model, :brand_name, :fab_year, :max_cap, presence: true
  validates :fab_year, length: { is: 4 }
  belongs_to :carrier
   
end
