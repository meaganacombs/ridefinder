class Drive < ActiveRecord::Base
  validates :num_passengers, :numericality => { :greater_than_or_equal_to => 1 }, :presence => true
  validates :city, :presence => true
  belongs_to :user
end
