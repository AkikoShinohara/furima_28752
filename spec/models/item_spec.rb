require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品の保存' do
    context '出品が保存できる場合' do
      it 'image,name, messages, category_id, condition_id, shopping_cost_id, prefecture_id, send_day_id, priceがあれば商品が保存される' do
        expect(@item).to be_valid
      end
      it 'category_idが0を選んでなければ保存される' do
        @item.category_id = '2'
        expect(@item).to be_valid
      end
      it 'condition_idが0を選んでなければ保存される' do
        @item.condition_id = '2'
        expect(@item).to be_valid
      end
      it 'shopping_cost_idが0を選んでなければ保存される' do
        @item.shopping_cost_id = '2'
        expect(@item).to be_valid
      end
      it 'prefecture_idが0を選んでなければ保存される' do
        @item.prefecture_id = '2'
        expect(@item).to be_valid
      end
      it 'send_day_idが0を選んでなければ保存される' do
        @item.send_day_id = '2'
        expect(@item).to be_valid
      end
      it '価格が300以上だと保存される' do
        @item.price = '300'
        expect(@item).to be_valid
      end
      it '価格が9_999_999以下だと保存される' do
        @item.price = '9_999_999'
        expect(@item).to be_valid
      end
    end
    context '商品の保存ができない場合' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end
      it 'nameが空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'messagesが空では保存できない' do
        @item.messages = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'ユーザーが紐づいてないとname, messages, category_id, condition_id, shopping_cost_id, prefecture_id, send_day_id, priceは保存されない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
      it 'category_idが0だと保存できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'condition_idが0だと保存できない' do
        @item.condition_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'shopping_cost_idが0だと保存できない' do
        @item.shopping_cost_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefecture_idが0だと保存できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の負担を選択してください')
      end
      it 'send_day_idが0だと保存できない' do
        @item.send_day_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが空だと保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'priceが半角数字でないと保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください')
      end
      it 'priceが300以下だと保存されない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が設定範囲外です')
      end
      it 'priceが9_999_999以上だと保存されない' do
        @item.price = '10_000_000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が設定範囲外です')
      end
    end
  end
end



