class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :artciles, through: :taggings
end
