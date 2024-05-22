class Article < ApplicationRecord
  enum :status, { :draft => 0, :published => 1 }, default: :draft

  validates :title, presence: true, length: { maximum: 140 }
  has_rich_text :body
  before_save :default_values

  def default_values
    self.body = "content will be here" if self.body == nil or self.body == ""
  end
end
