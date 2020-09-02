class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shopping_cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :send_day
  validates :image, :name, :messages, :category_id, :condition_id, :shopping_cost_id, :prefecture_id, :send_day_id, :price, presence: true
  validates :category_id, :condition_id, :shopping_cost_id,:prefecture_id, :send_day_id,  numericality: { other_than: 1 } 
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width numbers'}
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range'}
            
            

  belongs_to :user
  has_one  :payment
  has_one_attached :image

end
