module Sociable
  module Profile
    module Twitter
      module Mongoid
        extend ActiveSupport::Concern

        included do
          # twitter fields
          field :twitter_handle,              :type => String
          field :twitter_profile_image_url,              :type => String
          field :twitter_data, :type => String
          attr_accessible :twitter_handle, :twitter_profile_image_url, :twitter_data, :current_sign_in_ip

        end

        module ClassMethods

          def find_for_twitter_oauth(access_token, ip)
            data = access_token.info
            users_criteria = self.any_of({ twitter_handle: data.nickname }, { last_sign_in_ip: ip, name: data.name })
            if users_criteria.count > 0
              user = users_criteria.first
              user.update_attributes(twitter_handle: data.nickname,
                twitter_data: access_token.extra.raw_info,
                twitter_profile_image_url: data.image) unless (user.twitter_handle)
              user
            else
              self.create!(
                  password: Devise.friendly_token[0,20],
                  twitter_profile_image_url: data.image,
                  twitter_handle: data.nickname,
                  name: data.name,
                  twitter_data: access_token.extra.raw_info
              )
            end
          end
        end

        module InstanceMethods

          def new_with_session(params, session)
            super.tap do |user|
              if data = session["devise.twitter_data"] && session["devise.twitter_data"]["info"]
                user.twitter_handle = data["nickname"]
              end
            end
          end

        end

      end

      module ActiveRecord

      end

    end
  end
end