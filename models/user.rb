class User
  include Mongoid::Document
  include ActiveModel::Validations

  attr_accessor :username, :email, :password, :registration_date, :is_verified

  field :username, type: String
  field :email, type: String
  field :password, type: String
  field :registration_date, type: Time, default: Time.now
  field :is_verified, type: Boolean, default: false

  has_many :follows, class_name: "User", inverse_of: :user

  validates_presence_of :username, message: 'Please provide an username.'
  validates_uniqueness_of :username, message: 'This username is already taken.'
  validates_length_of :password, minimum: 6, message: 'The password should be at least 6 symbols.'

  def initialize(username, email, password)
    super(
      username: username,
      email: email,
      password: password,
    )
  end
end
