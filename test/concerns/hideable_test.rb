require "test_helper"

class HideableTest < ActiveSupport::TestCase
  test "scope hidden" do
    hidden_book = Book.create(title: "The Art of War", hidden: true)
    Book.create(title: "Alphabetic writing", hidden: false)

    assert_equal 1, Book.hidden.count
    assert_equal true, hidden_book.hidden?, "hidden_book is not hidden"
  end

  test "scope not_hidden" do
    Book.create(title: "The Art of War", hidden: true)
    not_hidden_book = Book.create(title: "Alphabetic writing", hidden: false)

    assert_equal 1, Book.not_hidden.count
    assert_equal false, not_hidden_book.hidden?, "not_hidden_book is hidden"
  end

  test "#hide!" do
    book = Book.create(title: "The Art of War", hidden: false)
    assert_equal false, book.hidden?, "book is hidden before hide!"

    book.hide!
    assert_equal true, book.hidden?, "book is not hidden after hide!"
  end

  test "#unhide!" do
    book = Book.create(title: "The Art of War", hidden: true)
    assert_equal true, book.hidden?, "book is not hidden before unhide!"

    book.unhide!
    assert_equal false, book.hidden?, "book is hidden after unhide!"
  end
end
