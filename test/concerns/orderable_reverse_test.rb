require 'test_helper'

class OrderableReverseTest < Capybara::Rails::TestCase
  test 'should persist reverse order for concern Ants:OrderableReverse' do
    Author.create(name: 'Ann Gilbert')
    Author.create(name: 'Ivan Sidorov')
    Author.create(name: 'Pierik Huston')

    assert_equal(['Pierik Huston', 'Ivan Sidorov', 'Ann Gilbert'], Author.all.map(&:name))
  end
end