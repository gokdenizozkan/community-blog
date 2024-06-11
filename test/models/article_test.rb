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
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
    @article = @user.articles.build(title: 'Test Article', body: 'This is a test article')
  end

  test 'should be valid' do
    assert @article.valid?
  end

  test 'title should be present' do
    @article.title = '   '
    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = 'a' * 141
    assert_not @article.valid?
  end

  test 'body should be default text if not present' do
    @article.body = nil
    @article.save
    assert_equal 'content will be here', @article.reload.body.to_plain_text
  end

  test 'should not update if published' do
    @article.published = true
    @article.save
    @article.title = 'Updated Title'
    assert_not @article.save
    assert_includes @article.errors[:base], 'Cannot update if it is published'
  end

  test 'should not destroy if published' do
    @article.published = true
    @article.save
    assert_not @article.destroy
    assert_includes @article.errors[:base], 'Cannot destroy if it is published'
  end
end
