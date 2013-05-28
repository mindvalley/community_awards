class NotificationMailer < ActionMailer::Base
  
  default from: "#{User.admin.first.email}"

  def first_reminder(users)
  	mail(:to => users, :subject => "IMPORTANT - Submit your 'name of the month' 2013 Community Awesomeness Awards")
  end

  def second_reminder(users)
  	mail(:to => users, :subject => "REMINDER: IMPORTANT - Submit your 'name of the month' 2012 Community Awesomeness Awards")
  end

  def third_reminder(users)
  	mail(:to => users, :subject => "FINAL REMINDER: IMPORTANT - Submit your 'name of the month' 2012 Community Awesomeness Awards")
  end

end
