include Rails.application.helpers
namespace :notifications do
	desc "third reminder"
	task :third => :environment do
		if Date.today == get_first_monday_of_the_month and Date.today.monday?
			NotificationMailer.third_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
		end
	end
	desc "first reminder"
	task :first => :environment do
		if Date.today == Date.today.end_of_month.beginning_of_week.next and Date.today.tuesday?
			NotificationMailer.first_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
		end
	end
	desc "second reminder"
	task :second => :environment do
		if Date.today == Date.today.end_of_month.beginning_of_week.advance(days: 4) and Date.today.monday?
			NotificationMailer.second_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
		end
	end
end