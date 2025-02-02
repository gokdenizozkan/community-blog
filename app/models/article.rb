# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  published  :boolean          default(FALSE)
#  user_id    :bigint           not null
#
class Article < ApplicationRecord
  scope :published, -> { where published: true }
  scope :not_published, -> { where published: false }

  validates :title, presence: true, length: { maximum: 140 }
  has_rich_text :body

  before_save :default_values
  before_update :prevent_update_if_published
  before_destroy :prevent_destroy_if_published

  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def is_published_in_words
    if self.published
      return "Published"
    end
    "Not published"
  end

  private
  def default_values
    unless self.body.present?
      self.body = "content will be here"
    end
  end

  def was_published?
    if self.published_changed?
      unless self.published
        true
      end
    else
      if self.published
        true
      end
    end
  end

  def prevent_update_if_published
    if self.was_published?
      errors.add :base, 'Cannot update if it is published'
      throw :abort
    end
  end

  def prevent_destroy_if_published
    if self.was_published?
      errors.add :base, 'Cannot destroy if it is published'
      throw :abort
    end
  end
end
