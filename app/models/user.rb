require 'oauth'

class User < ActiveRecord::Base
  has_one :download
  validates_presence_of :token, :secret

  devise :token_authenticatable, :trackable, :omniauthable

  attr_accessible :email, :token, :secret

  def self.find_or_create_via_sparkwire_oauth(auth_hash)
    creds = auth_hash['credentials']
    puts "got creds: #{creds.inspect}"
    unless user = User.find_by_token(creds['token'])
      user = create! :email => auth_hash['info']['email'],
        :token => creds['token'], :secret => creds['secret']
    end
    user
  end

  def latest_readings
    dl = Download.update(self, token, secret)
    doc = Nokogiri::XML dl.data
    doc.remove_namespaces!
    readings = doc.xpath('//IntervalReading')
    readings.inject([['Date','Reading']]) do |ary, r|
      ary << [
        Time.at(r.search('start').first.content.to_i).strftime('%m-%d-%Y %H:%M:%S'),
        r.search('value').first.content.to_i
      ]
    end
  end
end
