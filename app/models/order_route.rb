class OrderRoute < ApplicationRecord
  validates :date, :time, :coordinates, presence: true
  validate :date_is_past
  belongs_to :order_service

  def date_is_past
    if self.date.present? && self.date > Date.today
      self.errors.add(:date, ' não deve ser futura')
    end
  end
end
