namespace :notifications do
	desc "first reminder"
	task :first => :environment do
		NotificationMailer.first_reminder(Employee.pluck(:email)).deliver
	end
	desc "second reminder"
	task :second => :environment do
		NotificationMailer.second_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
	end
	desc "third reminder"
	task :third => :environment do
		NotificationMailer.third_reminder(Employee.votable.collect{|e| e.email unless e.votes.present?}.uniq).deliver
	end
end