module Sociable
  module Profile
    module Facebook
      module Mongoid
        extend ActiveSupport::Concern

        included do
          # facebook fields
          field :facebook_user_name,              :type => String
          field :facebook_image_url,              :type => String
          field :facebook_data, :type => String
          field :facebook_token, :type => String
          field :facebook_token_expiration, :type => String
          attr_accessible :facebook_user_name, :facebook_image_url, :facebook_data, :current_sign_in_ip

        end

        module ClassMethods

          def find_for_facebook_oauth(access_token, ip)
            data = access_token.info
            credentials=access_token.credentials
            users_criteria = self.any_of({ facebook_user_name: data.nickname }, { last_sign_in_ip: ip, name: data.name })
            if users_criteria.count > 0
              user = users_criteria.first
              user.update_attributes(facebook_user_name: data.nickname,
                                     facebook_data: access_token.extra.raw_info,
                                     facebook_image_url: data.image) unless (user.facebook_user_name)
              user.update_attribute(email: data.email) unless user.email
              user
            else
              self.create!(
                  password: Devise.friendly_token[0,20],
                  facebook_image_url: data.image,
                  facebook_user_name: data.nickname,
                  name: data.name,
                  email: data.email,
                  facebook_data: access_token.extra.raw_info

              )
            end
          end
        end

        module InstanceMethods

          def new_with_session(params, session)
            super.tap do |user|
              if data = session["devise.facebook_data"] && session["devise.facebook_data"]["info"]
                user.facebook_user_name = data["nickname"]
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