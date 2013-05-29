require 'rubygems'
require 'rufus/scheduler'
include Rails.application.helpers

scheduler = Rufus::Scheduler.start_new

if %w!production staging!.include? Rails.env
	scheduler.at get_first_monday_of_the_month do
	  NotificationMailer.third_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
	end

	scheduler.at Date.today.end_of_month.beginning_of_week.next.to_time do
	  NotificationMailer.first_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
	end

	scheduler.at Date.today.end_of_month.beginning_of_week.advance(days: 4).to_time do
	  NotificationMailer.second_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
	end
end
# scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
#   puts 'order pizza'
# end

# scheduler.cron '0 22 * * 1-5' do
#   # every day of the week at 22:00 (10pm)
#   puts 'activate security system'
# end

# scheduler.every '5m' do
#   puts 'check blood pressure'
# end