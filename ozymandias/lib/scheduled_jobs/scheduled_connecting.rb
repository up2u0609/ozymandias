require 'site_connector'
class ScheduledConnecting
  def process
    trackable_sites = Site.trackable_sites
    SiteConnector.new.check_connect(trackable_sites.collect(&:url)).each do|track_data|
      SiteTrack.create(
        :http_status_code => track_data.http_status_code,
        :speed => track_data.speed,
        :site_id => trackable_sites.detect{|s| s.url == track_data.url}.id
      )
    end
  end
end
