require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmation,f_nameとl_name,f_name_kanaとl_name_kana,birthdayが存在すれば登録できること' do
        expect(@user).to be_valid
      end
      it 'emailが@を含むと登録できる' do
        @user.email = 'test@gmail.com'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'qkikp0000'
        @user.password_confirmation = 'qkikp0000'
        expect(@user).to be_valid
      end
      it 'l_name, f_name全角（漢字・ひらがな）があると登録できる' do
        @user.l_name = '隆太郎'
        @user.f_name = '田中'
        expect(@user).to be_valid
      end
      it 'l_name_kana, f_name_kana全角（カタカナ）があると登録できる' do
        @user.l_name_kana = 'リクタロウ'
        @user.f_name_kana = 'タナカ'
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it '＠が含まれてないと登録できない' do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'qki00'
        @user.password_confirmation = 'qki00'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordは半角英数字混合でないと登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmation同じでないと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'l_name が空だと登録できない' do
        @user.l_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'l_name全角（漢字・ひらがな）でないと登録できない' do
        @user.l_name = 'シノハラ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は不正な値です')
      end
      it 'f_name が空だと登録できない' do
        @user.f_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'f_name 全角（漢字・ひらがな）でないと登録できない' do
        @user.l_name = 'シノハラ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は不正な値です')
      end
      it 'l_name_kanaが空だと登録できない' do
        @user.l_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カタカナを入力してください")
      end
      it 'l_name_kana全角（カタカナ）でないと登録できない' do
        @user.l_name_kana = 'しのはら'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カタカナは不正な値です')
      end
      it 'f_name_kanaが空だと登録できない' do
        @user.f_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字カタカナを入力してください")
      end
      it 'f_name_kana全角（カタカナ）でないと登録できない' do
        @user.f_name_kana = 'しのはら'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字カタカナは不正な値です')
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = 'しのはら'
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
