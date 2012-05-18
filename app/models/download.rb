require 'sparkwire'

class Download < ActiveRecord::Base
  belongs_to :user

  attr_accessible :data, :user_id

  def self.update(user, token, secret)
    if user.download && user.download.expired?
      user.download.destroy
    end
    if user.download.nil?
      user.create_download! :data => Sparkwire.fetch(token, secret)
    end
    user.download
  end

  def expired?
    created_at < 1.day.ago
  end
end
