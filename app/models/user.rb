class User < ActiveRecord::Base
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :auth_hash, :provider, :uid, :info, :credentials, :extra
  attr_accessor :name
  scope :admin, where(role: "admin")
  has_many :ballots, :foreign_key => "employee_id"
  def self.from_omniauth(auth)
  	uid = auth["uid"]
  	auth.delete("uid")
  	auth["uid"] = "#{uid}"
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["first_name"]
      user.email = auth["info"]["email"]
    end
  end

  def name
  	"#{self.first_name} #{self.last_name}"
  end

  # see http://stackoverflow.com/questions/3742785/rails-3-devise-current-user-is-not-accessible-in-a-model
  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  def admin?
    return true if self.role == 'admin'
  end

end
