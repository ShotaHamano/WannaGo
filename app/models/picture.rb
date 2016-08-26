class Picture < ActiveRecord::Base
  self.primary_key = :picture_id
  has_many :behaviors
  belongs_to :location
  attr_accessor :width, :height, :behavior_num, :size, :like_image_url, :like
end