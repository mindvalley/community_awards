class HomeController < ApplicationController
  def index
    @employees = Employee.votable
    # binding.pry
    unless (@ballot = Ballot.where(voter: current_user, period: current_period).first) and current_day >= 25
      # binding.pry
      @ballot = Ballot.new 
      @employees.each do |employee|
        @ballot.votes.build(candidate: employee.id)
      end
    end
  end
end
