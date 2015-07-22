class Redirect
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Search
  include Ants::Id


  ## Attributes
  field :path_from, type: String
  field :path_to,   type: String

  ## Validations
  validates :path_from, presence: true
  validates :path_to,   presence: true

  ## Search
  search_in :path_from, :path_to

  ## Scope
  default_scope -> { asc(:path_from) }

  ## Indexes
  index({ path_from: 1 })


  ## Callbacks
  after_validation :downcase_paths!


  ## Helpers
  def _list_item_title
    path_from
  end


  def _list_item_subtitle
    'created ' + ActionController::Base.helpers.time_ago_in_words(created_at) + ' ago'
  end


  ## Class Methods
  def self.match(request)
    # request.fullpath includes parameters and leading / so
    # add ending slash (Rails skips it) as alternative option
    fullpath      = request.fullpath.downcase
    fullpath_alt1 = fullpath.gsub('?', '/?')

    # decode URL to UTF string, e.g. %C3%A9 => é
    fullpath_alt2 = URI.unescape(fullpath)
    fullpath_alt3 = URI.unescape(fullpath_alt1)

    self.where(:path_from.in => [ fullpath, fullpath_alt1, fullpath_alt2, fullpath_alt3 ]).first
  end


  private

    def downcase_paths!
      self.path_from.downcase!
      self.path_to.downcase!

      return true
    end


end




