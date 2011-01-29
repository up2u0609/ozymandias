class SiteTracksController < ApplicationController
  def show
    @sites = Site.trackable_sites
  end
end
