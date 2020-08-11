class Style < ApplicationRecord
  has_many :products
  has_many :listings
end
