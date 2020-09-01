require 'rails_helper'

RSpec.describe Item, type: :model do
  before do 
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品の保存' do
    context "出品が保存できる場合" do
      it "image,name, messages, category_id, condition_id, shopping_cost_id, prefecture_id, send_day_id, priceがあれば商品が保存される" do
        expect(@item).to be_valid
      end
     it "category_idが1を選んでなければ保存される" do
        @item.category_id = "2"
        expect(@item).to be_valid
      end 
      it "condition_idが1を選んでなければ保存される" do
        @item.condition_id = "2"
        expect(@item).to be_valid
      end
      it "shopping_cost_idが1を選んでなければ保存される" do
        @item.shopping_cost_id = "2"
        expect(@item).to be_valid
      end
      it "prefecture_idが1を選んでなければ保存される" do
        @item.prefecture_id = "2"
        expect(@item).to be_valid
      end
      it "send_day_idが1を選んでなければ保存される" do
        @item.send_day_id = "2"
        expect(@item).to be_valid
      end
      it "価格が300以上だと保存される" do
        @item.price = "300"
        expect(@item).to be_valid
      end
      it "価格が9_999_999以下だと保存される" do
        @item.price = "9_999_999"
        expect(@item).to be_valid
      end
    end
    context '商品の保存ができない場合' do
      it "imageが空では保存できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空では保存できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "messagesが空では保存できない" do
        @item.messages = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Messages can't be blank")
      end
      it "ユーザーが紐づいてないとname, messages, category_id, condition_id, shopping_cost_id, prefecture_id, send_day_id, priceは保存されない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it "category_idが1だと保存できない" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "condition_idが1だと保存できない" do
        @item.condition_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it "shopping_cost_idが1だと保存できない" do
        @item.shopping_cost_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping cost must be other than 1")
      end
      it "prefecture_idが1だと保存できない" do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "send_day_idが1だと保存できない" do
        @item.send_day_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Send day must be other than 1")
      end
      it "priceが空だと保存できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが半角数字でないと保存できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width numbers")
      end
      it "priceが300以下だと保存されない" do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it "priceが9_999_999以上だと保存されない" do
        @item.price = "10_000_000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
    end
  end
end
