class SiteTrack < ActiveRecord::Base
  set_primary_key :created_at
  belongs_to :site
  scope :latest , order("created_at desc").limit(1)
end
