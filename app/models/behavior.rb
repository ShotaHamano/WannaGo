class Behavior < ActiveRecord::Base
  self.primary_key = :behavior_id
  belongs_to :picture
end