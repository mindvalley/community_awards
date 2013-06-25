class Vote < ActiveRecord::Base
  attr_accessible :ballot_id, :candidate, :employee_id, :points, :value_id
end
