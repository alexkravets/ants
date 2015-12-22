require 'test_helper'

class HideableTest < Capybara::Rails::TestCase
  test 'scope hidden, not_hidden should return proper objects' do
    hidden_book = Book.create(title: 'The Art of War', hidden: true)
    not_hidden_book = Book.create(title: 'Alphabetic writing', hidden: false)

    assert_equal(1, Book.hidden.count)
    assert_equal(1, Book.not_hidden.count)
    assert_equal(true, hidden_book.hidden?)
    assert_equal(false, not_hidden_book.hidden?)
  end

  test 'hide! should set hidden to true' do
    book = Book.create(title: 'The Art of War', hidden: false)
    assert_equal(false, book.hidden?)

    book.hide!
    assert_equal(true, book.hidden?)
  end

  test 'unhide! should set hidden to false' do
    book = Book.create(title: 'The Art of War', hidden: true)
    assert_equal(true, book.hidden?)

    book.unhide!
    assert_equal(false, book.hidden?)
  end
end