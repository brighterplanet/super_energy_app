require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Sparkwire < OmniAuth::Strategies::OAuth
      option :name, 'sparkwire'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, { :site => 'http://sparkwire.herokuapp.com' }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { request.params['user_id'] }

      info do
        { }
      end

      extra do
        { }
      end
    end
  end
end
