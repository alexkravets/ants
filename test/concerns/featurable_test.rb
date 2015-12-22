require 'test_helper'

class FeaturableTest < Capybara::Rails::TestCase
  test 'scope featured, not_featured should return proper objects' do
    featured_book = Book.create(title: 'The Art of War', featured: true)
    not_featured_book = Book.create(title: 'Alphabetic writing', featured: false)

    assert_equal(1, Book.featured.count)
    assert_equal(1, Book.not_featured.count)
    assert_equal(true, featured_book.featured?)
    assert_equal(false, not_featured_book.featured?)
  end

  test 'set_featured! should set featured to true' do
    book = Book.create(title: 'The Art of War', featured: false)
    assert_equal(false, book.featured?)

    book.set_featured!
    assert_equal(true, book.featured?)
  end

  test 'unset_featured! should set featured to false' do
    book = Book.create(title: 'The Art of War', featured: true)
    assert_equal(true, book.featured?)

    book.unset_featured!
    assert_equal(false, book.featured?)
  end
end