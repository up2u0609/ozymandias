class Site < ActiveRecord::Base
  has_many :site_tracks
  scope :trackable_sites, where(:is_trackable => true)
  def track_data_image_name(time = 1)
    "#{[self.name , self.id , time].join("_")}.png"
  end  
end
