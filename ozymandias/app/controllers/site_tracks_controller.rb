class SiteTracksController < ApplicationController
  def show
    if params[:id].blank?
      @sites = Site.trackable_sites
    else
      @site = Site.find(params[:id].to_i)
    end
  end
end
