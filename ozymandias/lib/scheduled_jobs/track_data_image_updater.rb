class TrackDataImageUpdater
  def process
    Site.trackable_sites.each do|s|
      SiteTrack::TRACK_TIME_RANGE.each do|t|
        g = Gruff::Area.new(500)
        g.title = "track of #{s.name} (#{s.url})"
        
        data_size = t * 12
        ary = s.site_tracks.in_recent_hours(t).collect(&:speed)
        until ary.size >= data_size
          ary << 0
        end
        g.data(s.name.to_sym, ary)
        
        labels = {}
        case t
        when 1..24
          (0..t).to_a.each do|h|
             labels[data_size * h/t] = "#{h} H"
          end
        when 24*3..24*30
           (0..(t/24)).to_a.each do|h|
             labels[data_size*h*24/t] = "#{h}D"
            end
        end
        g.labels = labels
        image_path = File.join(APP_CONFIG["track_data_images_dir"] , s.track_data_image_name(t))
        File.rm image_path if File.exist? image_path
        g.write(image_path)
      end
    end
  end
end
