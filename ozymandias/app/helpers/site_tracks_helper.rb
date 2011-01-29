module SiteTracksHelper
  def render_time_range_link(s)
    SiteTrack::TRACK_TIME_RANGE.map{|h|
      label = if h < 24
        "#{h} hours"
      else
        "#{h/24} days"      
      end
      link_to(label , site_track_path(s.id , :time => h ) , :remote => true)
    }.join("    ")
  end
end
