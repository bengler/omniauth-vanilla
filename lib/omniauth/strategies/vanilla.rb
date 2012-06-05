require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Vanilla < OmniAuth::Strategies::OAuth2

      DEFAULT_HOST = 'vanilla.o5.no'
            
      option :name, "vanilla"
      option :force_dialog, nil

      # TODO: HTTPS support.
      option :client_options, {
        :site => "http://#{host}",
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

      def self.host
        @host ||= case ENV['RACK_ENV']
          when 'development'
            'vanilla.dev'
          when 'staging'
            'vanilla.origo2.o5.no'
          else
            DEFAULT_HOST
        end
      end

      def user_info_endpoint
        "http://{self.class.host}/api/vanilla/v1/users/omniauth_hash"
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
