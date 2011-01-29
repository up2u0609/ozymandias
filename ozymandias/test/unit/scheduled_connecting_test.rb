require File.join(File.dirname(__FILE__), '../test_helper')
require 'scheduled_connecting'
class ScheduledConnectingTest < ActiveSupport::TestCase
  fixtures :sites
  test "connect trackable sites and leave track data in db" do
    assert_difference 'SiteTrack.count' , Site.trackable_sites.size do
      ScheduledConnecting.new.process
    end
  end
end
