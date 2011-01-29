require File.join(File.dirname(__FILE__), '../test_helper')

class SiteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :sites , :site_tracks
  test "can link site_track correctly" do
    p site_tracks(:one)
    p sites(:one).site_tracks
    assert sites(:one).site_tracks.include?(site_tracks(:one))
  end
  test "trackable_sites scoped finder" do
    assert Site.trackable_sites.include?(sites(:one))
    assert !Site.trackable_sites.include?(sites(:two))
  end
  test "can get and set site_tracks as children" do
    site_track = SiteTrack.create
    site = Site.create( :site_tracks => [site_track] )
    assert site.site_tracks.include?(site_track)
  end
  test "should can find image which display recent track" do
    assert_equal sites(:one).track_data_image_name , "#{sites(:one).name}_#{sites(:one).site_tracks.latest.first.created_at.to_i}.png"
  end
end
