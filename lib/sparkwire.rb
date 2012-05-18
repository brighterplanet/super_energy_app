require 'oauth'

module Sparkwire
  class FetchFailed < StandardError; end

  def self.fetch(token, secret)
    consumer = OAuth::Consumer.new ENV['SPARKWIRE_TOKEN'], ENV['SPARKWIRE_SECRET'], {
      :site => 'http://sparkwire.io',
      :scheme => :query_string
    }
    access_token = OAuth::AccessToken.from_hash consumer, {
      :oauth_token => token, :oauth_token_secret => secret
    }
    response = access_token.get '/electric_utility.xml'
    raise FetchFailed.new(response.code + ': ' + response.body) unless response.code.to_i < 300
    response.body
  end
end
