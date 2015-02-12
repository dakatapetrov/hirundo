class User
  include Mongoid::Document
  include ActiveModel::Validations

  attr_accessor :username, :email, :password, :password_confirmation, :registration_date, :is_verified

  field :username, type: String
  field :email, type: String
  field :password, type: String
  field :registration_date, type: Time, default: Time.now
  field :is_verified, type: Boolean, default: false

  has_many :follows, class_name: "User", inverse_of: :user

  validates_presence_of :username, message: 'Please provide an username.'
  validates_uniqueness_of :username, message: 'This username is already taken.'
  validates_presence_of :email, message: 'Please provide an email address.'
  validates_uniqueness_of :email, message: 'This e-mail is already used.'
  validates_length_of :password, minimum: 6, message: 'The password should be at least 6 symbols long.'
  validates_confirmation_of :password, message: 'Both passwords should match.'

  def initialize(username, password, password_confirmation, email)
    super(
      username: username,
      email: email,
      password: password,
      password_confirmation: password_confirmation
    )
  end

  class << self
    def findByUsername(username)
      User.find_by(username: username)
    end
  end

  def password?(password)
    @password.eql? password
  end
end
