FactoryBot.define do
  factory :payment_address do
    postal_code   { '123-4567' }
    prefecture    { '1' }
    city          { '東京都' }
    house_number  { '1-1' }
    building_name { '東京ハイツ' }
    phone_number  { '09088889999' }
    token         {'tok_48c09e205d158d365b0a594e3aff'}
  end
end
