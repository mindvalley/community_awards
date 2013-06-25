class Value < ActiveRecord::Base
  attr_accessible :name
  has_many :votes
end
