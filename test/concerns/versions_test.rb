require 'test_helper'

class VersionsTest < ActiveSupport::TestCase
  test '_document_versions return empty hash for blank history' do
    author = Author.create(name: 'Ann Gilbert')
    assert_equal({""=>"--"}, author._document_versions)
  end
end