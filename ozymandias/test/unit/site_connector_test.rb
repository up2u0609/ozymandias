require File.join(File.dirname(__FILE__), '../test_helper')
require 'site_connector'
class SiteConnectorTest < ActiveSupport::TestCase
  def setup
    @site_connector = SiteConnector.new
    @mock_sites = SiteConnector::HTTP_STATUS_ARY.each{|hs|
      hs[:url] = "test#{hs[:comment].parameterize}.com"
    }
  end
  test "can return track_data after send multible request" do
    stub_requests_sent(@mock_sites)
    track_data_ary = @site_connector.check_connect( @mock_sites.collect{|ms| ms[:url]} )
    @mock_sites.each do|ms|
      track_data = track_data_ary.detect{|td| td.url == ms[:url] }
      assert_not_nil track_data
      assert_equal track_data.http_status_code , ms[:http_status_code]
      assert_not_nil track_data.speed
      if  track_data.http_status_code.between?(200, 210)
        assert_equal track_data.speed , (1024 / 0.3).to_i
      else
        assert_equal track_data.speed , 0      
      end
    end
  end
private
  def stub_requests_sent(msa)
  #TO-DO : complete this method
    msa.each do|ms|
      response = Typhoeus::Response.new(:code => ms[:http_status_code], :headers => "", :body => "x" * 1024, :time => 0.3)
      @site_connector.connector.stub(:get, /#{Regexp.escape(ms[:url])}/).and_return(response)
    end
  end
end
