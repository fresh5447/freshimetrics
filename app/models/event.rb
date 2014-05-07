class Event < ActiveRecord::Base
  belongs_to :user
  has_many :parameters 
  accepts_nested_attributes_for :parameters, :allow_destroy => true
end
