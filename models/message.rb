class Message
  include Mongoid::Document
  include ActiveModel::Validations

  field :content, type: String
  field :location, type: String
  field :date, type: Time, default: ->{ Time.now }

  belongs_to :user

  validates_presence_of :content, message: 'Please provide content of the message.'
  validates_length_of :content, maximum: 150, message: 'The message should be maximum 150 symbols long.'

  def initialize(content, location, user)
    super(
      content: content,
      location: location,
      user: user
    )
  end
end
