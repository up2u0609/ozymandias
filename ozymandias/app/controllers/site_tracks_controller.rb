class SiteTracksController < ApplicationController
  def show
    respond_to do |h|
      h.html{
        @sites = Site.trackable_sites
        render
      }
      h.js{
        site = Site.find(params[:id].to_i)
        render :update do |page|
          html = if File.exist? File.join( APP_CONFIG["track_data_images_dir"] , site.track_data_image_name(params[:time]) )
                    image_tag( File.join("track_data_images" , site.track_data_image_name(params[:time])) )
                  else
                    content_tag(:em , "the data does not exist.")
                  end
          page.replace_html "track_data_image_#{params[:id]}" , html
        end
      }
    end
  end
end
