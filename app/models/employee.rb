class Employee < ActiveRecord::Base
  attr_accessible :date_joined, :email, :full_legal_name, :nick_name, :start_date, :status, :team, :voteable

  scope :votable, where(voteable: true)
  validates :email, :uniqueness => true

  has_many :votes
  # mount RailsAdminUplodEmployees::Engine => '/rails_admin_upload_employees', :as => 'rails_admin_upload_employees'
end
