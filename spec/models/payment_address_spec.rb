require 'rails_helper'

RSpec.describe PaymentAddress, type: :model do
  before do
    @payment_address = FactoryBot.build(:payment_address)
  end

  describe '出品商品の購入' do
    context '購入がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@payment_address).to be_valid
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式であると保存できること' do
        @payment_address.postal_code = '123-4567'
        expect(@payment_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @payment_address.building_name = nil
        expect(@payment_address).to be_valid
      end
      it 'prefecture0を選んでなければ保存できないこと' do
        @payment_address.prefecture = '1'
        expect(@payment_address).to be_valid
      end
    end
  end

  describe '出品商品の購入' do
    context '購入がうまくいかないとき' do
      it 'postal_codeが空では保存できないこと' do
        @payment_address.postal_code = ''
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んでないと保存できないこと' do
        @payment_address.postal_code = '1234567'
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureを0を選択すると保存できないこと' do
        @payment_address.prefecture = '0'
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @payment_address.city = ''
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @payment_address.house_number = ''
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @payment_address.phone_number = ''
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが11桁以上だと保存できないこと' do
        @payment_address.phone_number = '080111122223'
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空だと保存できないこと' do
        @payment_address.token = ''
        @payment_address.valid?
        expect(@payment_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
