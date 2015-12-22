require 'test_helper'

class ScheduledTest < Capybara::Rails::TestCase
  test 'scheduled books should have published_at greater then now' do
    book = Book.create(title: 'The Art of War', published_at: Time.zone.now)
    book = Book.create(title: 'Alphabetic writing', published_at: Time.zone.now + 3)

    assert_equal(1, Book.scheduled.count)
  end

  test 'published books should have published_at equal or less then now' do
    book = Book.create(title: 'Papyrus', published_at: Time.zone.now - 2)
    book = Book.create(title: 'Isidore of Seville', published_at: Time.zone.now - 3)
    book = Book.create(title: 'Manuscripts', published_at: Time.zone.now + 3)

    assert_equal(2, Book.published.count)
  end
end