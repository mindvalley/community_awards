class User
  include Mongoid::Document

  devise :omniauthable

  field :provider
  field :uid
  field :first_name
  field :last_name

  has_one :info, class_name: 'Employee'
  has_many :ballots, class_name: 'Ballot', inverse_of: :voter

  def self.all_who_voted(period)
    voters = []
    Ballot.where(period: period).each do |ballot|
      voters << ballot.voter
    end
    voters
  end

  def self.all_who_abstained(period)
    Employee.all.map {|employee| employee.user} - all_who_voted(period)
  end

  def can_vote?
    info.update_date_joined if info.date_joined.nil?
    info.status == 'confirmed' && ((Date.today - 6.months) > info.date_joined)
  end

  def self.find_for_googleapps_oauth(access_token, signed_in_resource=nil)
    data = access_token['info']

    if employee = Employee.where(email_address: data.email).first# && (employee && employee.eligible_to_vote?)
      if user = User.where(:email_address => data['email']).first
        # update user with information from access_token so we're current
        user.provider = access_token.provider
        user.uid = access_token.uid
        user.first_name = data.first_name
        user.last_name = data.last_name
        user.info = employee
        user.save!
      else #create a user with stub pwd
        user = User.create!(
          provider: access_token.provider,
          uid: access_token.uid,
          :email_address => data.email, :password => Devise.friendly_token[0,20],
          first_name: data.first_name,
          last_name: data.last_name,
        )
        user.info = employee
        user.save!
      end
      user

    else
      raise AccessDenied
    end
  end

end
