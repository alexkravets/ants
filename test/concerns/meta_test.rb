require 'test_helper'

class MetaTest < ActiveSupport::TestCase
  test 'meta_title, meta_description, meta_keywords, opengraph_image_url should return proper values' do
    meta_title = 'Book The Art of War'
    meta_description = 'The Art of War Description'
    meta_keywords = 'art, war'
    opengraph_image_url = 'https://placehold.it/30x30'

    book = Book.create(title: 'The Art of War', 
               published_at: Time.zone.now,
               _meta_title: meta_title,
               _meta_description: meta_description,
               _meta_keywords: meta_keywords,
               _opengraph_image_url: opengraph_image_url)

    assert_equal(meta_title, book.meta_title)
    assert_equal(meta_description, book.meta_description)
    assert_equal(meta_keywords, book.meta_keywords)
    assert_equal(opengraph_image_url, book.opengraph_image_url)
  end
end