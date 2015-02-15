class Message
  include Mongoid::Document
  include ActiveModel::Validations

  field :content, type: String
  field :location, type: String
  field :date, type: Time, default: ->{ Time.now }
  field :tags, type: Array

  belongs_to :user

  validates_presence_of :content, message: 'Please provide content of the message.'
  validates_length_of :content, maximum: 150, message: 'The message should be maximum 150 symbols long.'

  def initialize(content, location, user)
    super(
      content: content,
      location: location,
      user: user,
      tags: content.scan(/(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i).map(&:first)
    )
  end

  class << self
    def find_latest(limit = 50)
      Message.all.desc(:date).limit(limit)
    end

    def find_by_tags(tags, limit = 50)
      Message.all_in(tags: tags).desc(:date).limit(limit)
    end

    def find_by_user(user, limit = 50)
      Message.where(user: user).desc(:date).limit(limit)
    end
  end
end
