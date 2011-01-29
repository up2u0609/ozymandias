class TrackDataImageUpdater
  TIME_RANGE = [1 , 3 , 6 , 12 , 24 , 24*3 , 24*6 , 24*30]
  def process
    Site.trackable_sites.each do|s|
      TIME_RANGE.each do|t|
        g = Gruff::Line.new(400)
        g.title = "track of #{s.name} (#{s.url})"
        g.theme = {
          :colors => ['black', 'grey'],
          :marker_color => 'grey',
          :font_color => 'black',
          :background_colors => 'white'
        }
        labels = {}
        (0..t).to_a.each{|i|
          labels[i] = i.hours.ago.to_s(:db)
        }
        g.labels = labels
        g.data(s.name.to_sym, s.site_tracks.in_recent_hours(t).collect(&:speed))
        g.write(File.join(APP_CONFIG["track_data_images_dir"] , s.track_data_image_name(t)))
      end
    end
  end
end
