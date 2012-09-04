class Ballot
  include Mongoid::Document
  embeds_many :votes
  accepts_nested_attributes_for :votes, update_only: true

  belongs_to :voter, class_name: 'User'
  field :period
end
