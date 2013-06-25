class Ballot < ActiveRecord::Base
  attr_accessible :adjustment_factor, :employee_id, :period, :votes_attributes, :voter

  belongs_to :voter, :class_name => "Employee", foreign_key: "employee_id"
  has_many :votes

  accepts_nested_attributes_for :votes
  # default_scope Proc.new{|ballot| ballot.voter.order([:email, :asc]) }

  def self.compute_results(period)
    result = {}
    result.default = 0.0
    where(period: period).each do |ballot|
      af = ballot.adjustment_factor
      ballot.votes.each do |vote|
        next if vote.nil?
        begin
          candidate = Value.find(vote.candidate)
          result[candidate.name] += vote.points.to_f * af
        rescue Exception => e
          logger.error "#{e.message} #{e.backtrace}"
        end
      end
    end
    (result.sort_by {|k,v| v}).reverse
  end
  # def self.update_cron
  #   system 'bundle exec whenever --update-crontab store'
  # end

  # def self.schedule
  #   new_schedule = Schedule.new(Time.now)
  #   new_schedule.add_recurrence_rule Rule.monthly.day_of_week(
  #     :monday => [1],
  #     :tuesday => [-1],
  #     :friday => [-1]
  #   )
  # end
end
