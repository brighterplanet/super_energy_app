class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def home; end

  def dashboard
    @readings = current_user.latest_readings
  end
end
