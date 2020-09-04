class Payment < ApplicationRecord
  
  has_one:ship_address
  belongs_to:user
  belongs_to:item
end
