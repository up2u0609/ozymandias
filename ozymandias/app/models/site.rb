class Site < ActiveRecord::Base
  has_many :site_tracks
  scope :trackable_sites, where(:is_trackable => true)
  def track_data_image_name
    "#{self.name}_#{self.site_tracks.latest.first.created_at.to_i}.png"
  end  
end
