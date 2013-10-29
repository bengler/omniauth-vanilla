require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Vanilla < OmniAuth::Strategies::OAuth2

      DEFAULT_HOST = 'apressen.o5.no'

      def self.host
        @host ||= case ENV['RACK_ENV']
          when 'development'
            'vanilla.dev'
          when 'staging'
            'vanilla.staging.o5.no'
          else
            DEFAULT_HOST
        end
      end
            
      option :name, "vanilla"
      option :force_dialog, nil
      option :target_url, nil
      option :provider_ignores_state, true

      # TODO: HTTPS support.
      option :client_options, {
        :site => "http://#{Vanilla.host}",
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

      def user_info_endpoint
        "http://#{self.class.host}/api/vanilla/v1/users/omniauth_hash"
      end
            
      def raw_info
        @raw_info ||= access_token.get(user_info_endpoint).parsed
      end

      alias :old_request_phase :request_phase

      def request_phase 
        if options[:force_dialog]
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_dialog => 'true')
        end
        if options[:target_url]
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:target_url => options[:target_url])
        end
        old_request_phase
      end

    end
  end
end
