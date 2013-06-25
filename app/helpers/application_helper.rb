module ApplicationHelper
	def get_first_monday_of_the_month
		if Date.today.beginning_of_month.beginning_of_week < Date.today.beginning_of_month
			Date.today.beginning_of_month.next_week
		else
			Date.today.beginning_of_month.beginning_of_week
		end
	end
end
