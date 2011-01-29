require File.join(File.dirname(__FILE__), '../test_helper')
require 'track_data_image_updater'
class TrackDataImageUpdaterTest < ActiveSupport::TestCase
  fixtures :sites , :site_tracks
  test "should create/update image which display track data after process" do
    FileUtils.rm Dir["#{APP_CONFIG["track_data_images_dir"]}/*.png"]
    TrackDataImageUpdater.new.process
    assert Site.trackable_sites.all?{|s|
      TrackDataImageUpdater::TIME_RANGE.all?{|h|
        File.exist? File.join(APP_CONFIG["track_data_images_dir"] , s.track_data_image_name(h))
      }
    }
    FileUtils.rm Dir["#{APP_CONFIG["track_data_images_dir"]}/*.png"]
  end
end
