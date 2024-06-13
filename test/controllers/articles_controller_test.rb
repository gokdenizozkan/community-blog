require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @article = articles(:valid_article_published)
    @article_not_published = articles(:valid_article_not_published)
    @user = users(:valid_user)
    sign_in @user
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should show article' do
    get article_url('tr', @article)
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New Article', body: 'Article Body', published: false, tags: "" } }
    end
    assert_redirected_to article_url(Article.last)
  end

  test 'should update article if it is not published' do
    patch article_url('tr', @article_not_published), params: { article: { title: 'Updated Title', tags: "" } }
    assert_redirected_to article_url('tr', @article_not_published)
    @article_not_published.reload
    assert_equal 'Updated Title', @article_not_published.title
  end

  test 'should destroy article if it is not published' do
    assert_difference('Article.count', -1) do
      delete article_url('tr', @article_not_published)
    end
    assert_redirected_to articles_url
  end
end
