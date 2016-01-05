require "test_helper"

class OrderableReverseTest < ActiveSupport::TestCase
  test "Ants:OrderableReverse" do
    Author.create(name: "Ann Gilbert")
    Author.create(name: "Ivan Sidorov")
    Author.create(name: "Pierik Huston")

    assert_equal(["Pierik Huston", "Ivan Sidorov", "Ann Gilbert"], 
                 Author.all.map(&:name))
  end
end
