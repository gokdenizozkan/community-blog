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
  attributes :title, :status, :published
  attribute :body, key: :content

  has_many :tags

  has_many :comments do
    @object.comments.approved
  end

  def status
    @object.published ? :published : :draft
  end
end
