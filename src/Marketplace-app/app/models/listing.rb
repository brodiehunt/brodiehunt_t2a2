class Listing < ApplicationRecord
  belongs_to :brand
  belongs_to :style
  belongs_to :size
  belongs_to :state
  belongs_to :city
  belongs_to :postcode
  belongs_to :user
  has_one_attached :picture

  scope :filter_by_brand_id, -> (brand_id) { where brand_id: brand_id }
  scope :filter_by_style_id, -> (style_id) { where style_id: style_id }
  scope :filter_by_size_id, -> (size_id) { where size_id: size_id }
  scope :filter_by_state_id, -> (state_id) { where state_id: state_id }
end
