class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :style
  belongs_to :size
  has_one_attached :picture

  scope :filter_by_brand_id, -> (brand_id) { where brand_id: brand_id }
  scope :filter_by_style_id, -> (style_id) { where style_id: style_id }
  scope :filter_by_size_id, -> (size_id) { where size_id: size_id }
end
