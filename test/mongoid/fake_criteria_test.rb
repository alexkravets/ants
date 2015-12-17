require 'test_helper'

class FakeCriteriaTest < Capybara::Rails::TestCase
  test 'limit & count for Mongoid::FakeCriteria' do
    books = Mongoid::FakeCriteria.new(['book 1', 'book 2', 'book 3', 'book 4'])

    assert_equal(books.limit(2).raw, ['book 1', 'book 2'])
    assert_equal(books.limit(0).raw, ['book 1', 'book 2', 'book 3', 'book 4'])
    assert_equal(books.limit(6).raw, ['book 1', 'book 2', 'book 3', 'book 4'])

    assert_equal(books.count, 4)
  end
end