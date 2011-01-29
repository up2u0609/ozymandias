require File.join(File.dirname(__FILE__), '../test_helper')
require 'track_data_image_updater'
class TrackDataImageUpdaterTest < ActiveSupport::TestCase
  fixtures :sites , :site_tracks
  test "should create/update image which display track data after process" do
    FileUtils.rm Dir["#{APP_CONFIG["track_data_images_dir"]}/*.png"]
    30.times{|t| SiteTrack.create(:site => sites(:one), :speed => rand(500) , :http_status_code => 200, :created_at => (t*5).minutes.ago)}
    TrackDataImageUpdater.new.process
    assert Site.trackable_sites.all?{|s|
      SiteTrack::TRACK_TIME_RANGE.all?{|h|
        File.exist? File.join(APP_CONFIG["track_data_images_dir"] , s.track_data_image_name(h))
      }
    }
  end
end
