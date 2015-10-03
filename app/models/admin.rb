class Admin
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Ants::Id

  ## Attributes
  field :name
  field :permissions, type: Array


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String


  ## Validations
  validates :name,  presence: true


  ## Search
  search_in :name, :email

  ## Scopes
  default_scope -> { asc(:name) }


  ## Indexes
  index({ name:  1 })
  index({ email: 1 }, { unique: true })


  ## Helpers
  def devise_mailer
    AdminMailer
  end


  def _list_item_title
    name.empty? ? email : name
  end


  def _list_item_subtitle
    last_sign_in_ago
  end


  def _list_item_thumbnail
    "//www.gravatar.com/avatar/#{ Digest::MD5.hexdigest(email) }?s=80&d=retro&r=g"
  end


  private

    def last_sign_in_ago
      if last_sign_in_at
        'Seen ' + ActionController::Base.helpers.time_ago_in_words(last_sign_in_at) + ' ago'
      else
        'Never seen'
      end
    end

end




