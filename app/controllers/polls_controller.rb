class PollsController < ApplicationController
  def index
    @employees = Employee.votable
    # binding.pry
    # unless (@ballot = Ballot.where(voter: current_user, period: current_period).first)
    #   # binding.pry
    #   @ballot = Ballot.new
    #   @employees.each do |employee|
    #     @ballot.votes.build(candidate: employee.id)
    #   end
    # end
    @employees = Employee.votable
    # @ballot = Ballot.new
    unless (@ballot = Ballot.where(employee_id: Employee.find_by_email(current_user.email).try(:id), period: current_period).first)
      @ballot = Ballot.new
      @employees.each do |employee|
        @ballot.votes.build(candidate: employee.id)
      end
    end
  end

  def create
    @ballot = Ballot.new(params[:ballot].merge(employee_id: Employee.find_by_email(current_user.email).id, period: current_period))
    respond_to do |format|
      if @ballot.save
        @ballot.votes.update_all("employee_id = #{@ballot.employee_id}")
        format.html { redirect_to root_url, notice: 'Ballot was successfully created.' }
      else
        format.html { redirect_to root_url, notice: 'Unable to save ballot.' }
      end
    end
  end

  def update
    @ballot = Ballot.find(params[:id])

    respond_to do |format|
      @ballot.votes.each_with_index do |vote, index|
        vote.update_attributes(params[:ballot][:votes_attributes][index])
      end
      format.html { redirect_to root_url, notice: 'Ballot was successfully updated.' }
    end
  end
end
