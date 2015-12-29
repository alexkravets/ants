require 'test_helper'

class SortedRelationsTest < ActiveSupport::TestCase
  test 'sorted_relations_for shoud persist for N to N relation' do
    book = Book.create(title: 'The Art of War')
    book.sorted_author_ids = [ Author.create(:name => 'Sun Tzu').id,
                               Author.create(:name => 'Sun Wu' ).id,
                               Author.create(:name => 'Lao Zi' ).id ]
    book.save
    book.reload
    book.sorted_author_ids = book.author_ids.map { |id| id.to_s }.reverse
    assert_equal(['Lao Zi', 'Sun Wu', 'Sun Tzu'], book.sorted_authors.map(&:name))
  end

  test 'sorted_relations_for shoud persist for 1 to N relation' do 
    book = Book.create(title: 'War and Piece')
    book.sorted_chapter_ids = [ Chapter.create(:title => 'The End').id,
                                Chapter.create(:title => 'Part 3').id,
                                Chapter.create(:title => 'Part 2').id,
                                Chapter.create(:title => 'Part 1').id,
                                Chapter.create(:title => 'Intro').id ]
    book.reload
    book.sorted_chapter_ids = book.chapter_ids.map { |id| id.to_s }.reverse
    assert_equal(['Intro', 'Part 1', 'Part 2', 'Part 3', 'The End'], book.sorted_chapters.map(&:title))
  end
end