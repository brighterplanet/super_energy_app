require 'omniauth-oauth'
require 'json'

module OmniAuth
  module Strategies
    class Sparkwire < OmniAuth::Strategies::OAuth
      option :name, 'sparkwire'

      option :client_options, { :site => 'http://sparkwire.io' }

      uid { request.params['user_id'] }

      info do
        { 'email' => raw_info['email'] }
      end

      def raw_info
        @raw_info ||= profile
      end

      def profile
        puts access_token.inspect
        response = access_token.get('/profile.json')
        puts response.code, response.body
        if response.code.to_i < 300
          JSON.parse response.body
        else
          {}
        end
      end
    end
  end
end

