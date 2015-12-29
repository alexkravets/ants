require 'test_helper'

class IdTest < ActiveSupport::TestCase
  test 'Id concern serialize _id & _ids ending values to string' do
    author = Author.create(name: 'Ann Gilbert')
    
    author.serializable_hash.each_pair do |k, v|
      if k.end_with?('_id')
        assert_equal(String, v.class)
      end

      if k.end_with?('_ids')
        author.attributes[k].each do |value|
          assert_equal(String, value.class)
        end
      end
    end
  end
end