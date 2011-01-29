class SiteTrack < ActiveRecord::Base
  set_primary_key :created_at
  belongs_to :site
  scope :latest , order("created_at desc").limit(1)
  scope :in_recent_hours , lambda {|hour_count| where("created_at >= ?" , hour_count.hours.ago).order("created_at desc") }
end
