class NotificationMailer < ActionMailer::Base
  default from: "justynak@mindvalley.com"

  def first_reminder(users)
  	mail(:to => users, :subject => "IMPORTANT - Submit your '#{Date::MONTHNAMES[current_period.split('-').last.to_i]}' 2013 Community Awesomeness Awards")
  end

  def second_reminder(users)
  	mail(:to => users, :subject => "REMINDER: IMPORTANT - Submit your '#{Date::MONTHNAMES[current_period.split('-').last.to_i]}' 2012 Community Awesomeness Awards")
  end

  def third_reminder(users)
  	mail(:to => users, :subject => "FINAL REMINDER: IMPORTANT - Submit your '#{Date::MONTHNAMES[current_period.split('-').last.to_i]}' 2012 Community Awesomeness Awards")
  end
  def test
    mail(:to => 'furqan@mindvalley.com', :subject => 'test')
  end

end
