# -------------------------------------------------------------------
# Make sure /config/initializers/device.rb includes :email like:
#
# config.case_insensitive_keys = [ :email ]
#
# This is required to make it possible for users login with case
# insensative emails.
# -------------------------------------------------------------------
class Admin
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Search
  include Ants::Id


  ## Attributes
  field :name
  field :permissions, type: Array

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :validatable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :authentication_keys => [ :email ]

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

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time


  ## Validations
  validates :name,  presence: true
  validates :email, presence: true, allow_blank: false, uniqueness: true


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


  def last_sign_in_ago
    if last_sign_in_at
      'Seen ' + ActionController::Base.helpers.time_ago_in_words(last_sign_in_at) + ' ago'
    else
      'Never seen'
    end
  end


  def _list_item_title
    name.empty? ? email : name
  end


  def _list_item_subtitle
    last_sign_in_ago
  end


  def _list_item_thumbnail
    "http://www.gravatar.com/avatar/#{ Digest::MD5.hexdigest(email) }?s=80&d=retro&r=g"
  end

end




