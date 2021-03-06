class PaymentAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, :prefecture, :city, :house_number, :phone_number
    validates :token
  end
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン（-）を含めてください' }
  validates :prefecture, numericality: { other_than: 0, message: 'を選択してください'}
  validates :phone_number, format: { with: /\A\d{11}\z/, message: 'は半角数字で入力してください' }

  def save
    payment = Payment.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, payment_id: payment.id)
  end
end
