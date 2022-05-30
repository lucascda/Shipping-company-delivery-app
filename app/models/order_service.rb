class OrderService < ApplicationRecord
  validates :source_adress, :dest_adress, :code, :product_code, :volume, :weight,
            :order_status, :accepted_status, presence: true
  validates :volume, :weight, comparison: { greater_than: 0}
  validates :code, uniqueness: true
  # carrier presente no momento da aceitacao do pedido
  
  before_validation :generate_code
  belongs_to :carrier
  belongs_to :vehicle, optional: true

  enum accepted_status: { waiting: 0, done: 1 }
  enum order_status: { awaiting_approval: 0, approved: 1, refused: 2, delivered: 3}

  has_many :order_routes
  private

  def generate_code
    if !self.code.present?
      self.code = SecureRandom.alphanumeric(15).upcase
    end
  end

  

  
end
