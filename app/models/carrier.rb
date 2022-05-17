class Carrier < ApplicationRecord
  enum status: { active: 0, inactive: 1}
  validates :corporate_name, :brand_name, :email_domain, :registration_number,
            :adress, :city, :state, :country, :status, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: {is: 14}
end
