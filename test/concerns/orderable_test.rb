require 'test_helper'

class OrderableTest < Capybara::Rails::TestCase
  test 'should persist direct order for concern Ants:Orderable' do
    Book.create(title: 'Papyrus')
    Book.create(title: 'Isidore of Seville')
    Book.create(title: 'Manuscripts')

    assert_equal(['Papyrus', 'Isidore of Seville', 'Manuscripts'], Book.all.map(&:title))
  end
end