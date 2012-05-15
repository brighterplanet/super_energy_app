class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def home; end

  def dashboard
    #current_user.fetch_data unless current_user.download
    #@readings = current_user.download
    doc = Nokogiri::XML(open(Rails.root.join 'doc/sample_data.xml'))
    doc.remove_namespaces!
    readings = doc.xpath('//value').map { |v| v.children.first.to_s }.map(&:to_i)
    readings.pop
    @readings = (1..readings.length).zip readings
  end
end
