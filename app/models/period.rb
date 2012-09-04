class Period
  include Mongoid::Document

  has_many :votes
  has_many :candidates

  field :results, type: Array

  def calc_results(salaries = {})
    # calculate the results
    # return an array of hashes of the form:
    # name: 'tristan', points: 320
  end

end
