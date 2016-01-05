require "test_helper"

class FeaturableTest < ActiveSupport::TestCase
  test "#featured?" do
    featured_book = Book.create(title: "The Art of War", featured: true)
    not_featured_book = Book.create(title: "Alphabetic writing",
                                    featured: false)

    assert_equal 1,
                 Book.featured.count,
                 "featured book must be 1 instead: #{Book.featured.count}"
    assert_equal 1,
                 Book.not_featured.count,
                 "not_featured book must be 1 instead:
                 #{Book.not_featured.count}"
    assert_equal true,
                 featured_book.featured?,
                 "featured_book is not featured"
    assert_equal false,
                 not_featured_book.featured?,
                 "not_featured_book is featured"
  end

  test "#set_featured!" do
    book = Book.create(title: "The Art of War", featured: false)
    assert_equal false, book.featured?, "book is featured before set"

    book.set_featured!
    assert_equal true, book.featured?, "book is not featured sfter set"
  end

  test "unset_featured!" do
    book = Book.create(title: "The Art of War", featured: true)
    assert_equal true, book.featured?, "book is not featured before unset"

    book.unset_featured!
    assert_equal false, book.featured?, "book is featured after unset"
  end
end
