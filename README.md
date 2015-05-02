# ants
Collection of concerns and helpers for Rails + Mongoid + Character web development


### Sorted Relations

In Mongoid, the HM & HABTM relations return docs in the wrong order. This workaround provides an ability to retrieve related documents in the same order it was stored.

Usage example:

  ```ruby
  class Post
    include Mongoid::Document
    include Ants::SortedRelations

    field :title

    has_and_belongs_to_many :authors
    sorted_relations_for :authors
  end

  post = Post.new title: 'RESTful actions with Mongosteen'
  post.sorted_author_ids = [ Author.create(name: "Oleksandr Kravets").id,
                             Author.create(name: "Roman Brazhnyk"   ).id,
                             Author.create(name: "Maxim Melnyk"     ).id ]

  post.sorted_authors.map(&:name)
  #=> ['Alexander Kravets', 'Roman Brazhnyk', 'Maxim Melnyk']
  ```

