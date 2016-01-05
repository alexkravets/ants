require "test_helper"

class ContentTest < ActiveSupport::TestCase
  test "alias _list_item_title" do
    book = Book.create(title: "The Art of War")
    assert_equal("The Art of War", book._list_item_title)
  end

  test "#canonical_url" do
    book = Book.create(title: "The Art of War")
    if Rails.env.production?
      protocole = Rails.application.config.force_ssl ? "https://" : "http://"
    else
      protocole = ""
    end
    ENV["HOST"] = "localhost"
    host = (Rails.env.production? ? ENV.fetch("HOST") : "")
    slug = book.slug
    assert_equal "#{protocole}#{host}/#{slug}",
                 book.canonical_url,
                 "canonical_url return not protocole+host+slug:
                  #{book.canonical_url}"
  end

  test "#meta_type" do
    book = Book.create(title: "The Art of War")
    assert_equal "article",
                  book.meta_type,
                  "meta_type not equal to 'article': #{book.meta_type}"
  end

  test "#meta_title" do
    book = Book.create(title: "The Art of War")
    assert_equal "", book._meta_title, "_meta_title not empty"
    assert_equal "The Art of War",
                 book.meta_title,
                 "should return title if _meta_title is undefined"
  end
end
