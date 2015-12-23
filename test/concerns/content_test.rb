require 'test_helper'

class ContentTest < Capybara::Rails::TestCase
  test 'alias _list_item_title should return title' do
    book = Book.create(title: 'The Art of War')
    assert_equal('The Art of War', book._list_item_title)
  end

  test 'canonical_url should look protocole+host+slug' do
    book = Book.create(title: 'The Art of War')
    protocole = Rails.application.config.force_ssl ? "https://" : "http://"
    ENV['HOST'] = 'localhost'
    host = ENV.fetch('HOST')
    slug = book.slug
    assert_equal("#{protocole}#{host}/#{slug}", book.canonical_url)
  end

  test 'meta_type should be an article' do  
    book = Book.create(title: 'The Art of War')
    assert_equal('article', book.meta_type)
  end

  test 'meta_title should return title if _meta_title is undefined' do
    book = Book.create(title: 'The Art of War')
    assert_equal('', book._meta_title)
    assert_equal('The Art of War', book.meta_title)
  end
end