module ApplicationHelper
	def get_first_monday_of_the_month
		if Date.today.beginning_of_month.beginning_of_week < Date.today.beginning_of_month
			return Date.today.beginning_of_month.next_week.to_time
		else
			return Date.today.beginning_of_month.beginning_of_week.to_time
		end
	end
end
