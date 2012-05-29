require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Vanilla < OmniAuth::Strategies::OAuth2
            
      USERINFO_ENDPOINT = 'http://vanilla.o5.no/api/vanilla/v1/users/omniauth_hash'

      option :name, "vanilla"
      option :force_dialog, nil

      # TODO: HTTPS support.
      option :client_options, {
        :site => 'http://vanilla.o5.no',
        :token_url => '/api/vanilla/v1/oauth/token',
        :authorize_url => '/api/vanilla/v1/oauth/authorize'
      }

      uid {
        raw_info['uid'].to_s
      }
        
      info do
        raw_info['info']
      end

      extra do
        {'raw_info' => raw_info}
      end
            
      def raw_info
        @raw_info ||= access_token.get(USERINFO_ENDPOINT).parsed
      end

      alias :old_request_phase :request_phase

      def request_phase 
        if options[:force_dialog]
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_dialog => 'true')
        end
        old_request_phase
      end

    end
  end
end
