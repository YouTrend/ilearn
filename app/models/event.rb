class Event < ApplicationRecord
	belongs_to :course
	validates_presence_of :start_time,:end_time
end
