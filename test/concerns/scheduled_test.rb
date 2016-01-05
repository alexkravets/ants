require 'test_helper'

class ScheduledTest < ActiveSupport::TestCase
  test "Ants:Scheduled" do
    Book.create(title: 'The Art of War', published_at: Time.zone.now)
    Book.create(title: 'Alphabetic writing', published_at: Time.zone.now + 3)

    assert_equal(1, Book.scheduled.count)
  end

  test 'published books should have published_at equal or less then now' do
    Book.create(title: 'Papyrus', published_at: Time.zone.now - 2)
    Book.create(title: 'Isidore of Seville', published_at: Time.zone.now - 3)
    Book.create(title: 'Manuscripts', published_at: Time.zone.now + 3)

    assert_equal(2, Book.published.count)
  end
end