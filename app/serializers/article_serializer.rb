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
class ArticleSerializer < ActiveModel::Serializer
  attribute :title
  attribute :body, key: :content
  attributes :status, :published

  has_many :comments do
    @object.comments.approved
  end
  has_many :tags

  def body
    @object.body.to_plain_text
  end

  def status
    @object.published ? :published : :draft
  end

  def published
    @object.updated_at
  end
end
