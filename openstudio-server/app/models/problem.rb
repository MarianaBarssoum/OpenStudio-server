class Problem
  include Mongoid::Document

  #has_many :workflow_steps

  belongs_to :analysis

  has_many :variables
end
