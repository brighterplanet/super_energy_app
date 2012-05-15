class UsersController < ApplicationController
  def new
    doc = Nokogiri::XML(open(Rails.root.join 'doc/sample_data.xml'))
    doc.remove_namespaces!
    readings = doc.xpath('//value').map { |v| v.children.first.to_s }.map(&:to_i)
    readings.pop
    @readings = (1..readings.length).zip readings
  end
end
