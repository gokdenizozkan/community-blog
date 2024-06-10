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
