class Employee
  include Mongoid::Document

  scope :votable, where(votable: true)

  default_scope order_by(email_address: :asc)

  field :email, type: String
  validates :email_address, uniqueness: true

  field :date_joined, type: Date
  field :votable, type: Boolean, default: true
  field :team, type: String, default: ->{ team.nil? ? '' : team.downcase }
  field :status

  belongs_to :user
end
