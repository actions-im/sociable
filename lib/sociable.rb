
module Sociable

  module Profile
    autoload :Facebook, 'sociable/model/facebook'
    autoload :Twitter, 'sociable/model/twitter'
  end

  mattr_accessor :twitter_omniauth_settings

  mattr_accessor :facebook_omniauth_settings

  def self.twitter (*args)
    @twitter_omniauth_settings=["twitter"]
    @twitter_omniauth_settings<<args
  end

  def self.facebook (*args)
    @facebook_omniauth_settings=["facebook"]
    @facebook_omniauth_settings<<args
  end


  def self.setup
    yield self

    Devise.setup do |config|

      config.send(:omniauth, *@twitter_omniauth_settings) unless @twitter_omniauth_settings.empty?

      config.send(:omniauth, *@facebook_omniauth_settings) unless @facebook_omniauth_settings.empty?

    end
  end

end
