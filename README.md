
Ants
======
[![GitHub version](https://badge.fury.io/gh/slate-studio%2Fants.svg)](http://badge.fury.io/gh/slate-studio%2Fants)
[![Build Status](https://travis-ci.org/slate-studio/ants.svg)](https://travis-ci.org/slate-studio/ants)
[![Code Climate](https://codeclimate.com/github/slate-studio/ants/badges/gpa.svg)](https://codeclimate.com/github/slate-studio/ants)
[![Coverage Status](https://coveralls.io/repos/slate-studio/ants/badge.svg)](https://coveralls.io/r/slate-studio/ants)

Collection of concerns and helpers for Rails + Mongoid + Character web development


### Orderable

Adds ordering functionality to the model. Default order is assending by `_position` field.

Usage:

```ruby
  include Ants:Orderable
```

**NOTE:** If this concern is added to model with already existing documents, value for `_position` field should be initialized with this command:

```ruby
ModelClass.all.set(_position: 1000)
```


### Meta

Adds set of page meta fields and creates default methods that should be overriden if necessary:

- `_meta_title`
- `_meta_description`
- `_meta_keywords`
- `_opengraph_image_url`

Usage:

```ruby
  include Ants:Meta
```


### Hideable

When you need to hide some documents from public or often used as draft analogue:

Usage:

```ruby
  include Ants:Hideable
```

Scopes:

- `hidden`
- `not_hidden`

Helpers:

- `hide!`
- `unhide!`
- `hidden?`


### Slug



### Sorted Relations

In Mongoid, the HM & HABTM relations return docs in random order. This workaround provides an ability to retrieve related documents in the same order it was stored.

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


### Versions

Provides a helper method to get a list of document versions, used by `chr` + `mongosteen`:

Usage:

```ruby
  include Ants:Versions
```

Helpers:

- `_document_versions`




