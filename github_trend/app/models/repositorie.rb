class Repositorie < ApplicationRecord
  validates :name, presence: true
  validates :type, presence: true
  validates :name, length: { maximum: 25 }
  validates :discription, length: { maximum: 255 }
end
