class Result < ActiveRecord::Base
  attr_accessible :lines, :period
  serialize :lines, ActiveRecord::Coders::Hstore
end
