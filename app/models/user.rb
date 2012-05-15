require 'oauth'

class User < ActiveRecord::Base
  has_one :download

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def fetch_data
    client = OAuth::Consumer.new('VQsuZ8FPlbhEtVqvsKK1xszAR9IUg5PIVb5CLlpU', 'x3EbQpa19fEEtrWoOGQvGTknyyvJYMRwyDVrNDzM', {
      :site => 'http://super-energy-app.herokuapp.com',
      :scheme => :query_string,
      :http_method => :post
    })
    access_token = OAuth::AccessToken.from_hash client, {
      :oauth_token => current_user.token, :oauth_token_secret => current_user.secret
    }

    doc = Nokogiri::XML(open(Rails.root.join 'doc/sample_data.xml'))
    doc.remove_namespaces!
    readings = doc.xpath('//value').map { |v| v.children.first.to_s }.map(&:to_i)
    readings.pop
    readings = (1..readings.length).zip readings
  end

  def self.find_for_sparkwire_oauth(access_token, signed_in_resource=nil)
    self.create!(:email => Devise.friendly_token[0,20] + '@xample.com', :password => Devise.friendly_token[0,20]) 
  end
end
