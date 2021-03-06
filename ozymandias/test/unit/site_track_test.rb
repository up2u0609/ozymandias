require File.join(File.dirname(__FILE__), '../test_helper')

class SiteTrackTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :sites , :site_tracks
  test "can get and set site_tracks as children" do
    assert_equal site_tracks(:one).site, sites(:one)
  end
  test "should return latest" do
    assert_equal SiteTrack.latest.first , site_tracks(:two)
  end
  test "should return in_recent_hours" do
    assert SiteTrack.in_recent_hours(1).include?(site_tracks(:one))
    assert !SiteTrack.in_recent_hours(1).include?(site_tracks(:three))
  end
end
