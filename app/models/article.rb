class Article < ApplicationRecord
  scope :published, -> { where(published: true) }

  validates :title, presence: true, length: { maximum: 140 }
  has_rich_text :body
  before_save :default_values

  def default_values
    unless self.body.present?
      self.body = "content will be here"
    end
  end
end
