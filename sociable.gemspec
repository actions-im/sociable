$LOAD_PATH.unshift 'lib'
require "sociable/version"

Gem::Specification.new do |s|
  s.name              = "sociable"
  s.version           = Sociable::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "This gem will make your rails app social in 30 seconds or less."
  s.homepage          = "https://github.com/actions/sociable"
  s.email             = "sergey@actions.im"
  s.authors           = [ "Sergey Zelvenskiy" ]
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("man/**/*")
  s.files            += Dir.glob("test/**/*")

#  s.executables       = %w( sociable )
  s.description       = "
  Sociable gem provides abilities to share various user actions happening in your app and present these on custom newsfeed.
  The following features can be seamlessly added to your app.
  1. Create user account using Facebook or Twitter profiles.
  2. Invite friends from email address book, facebook, twitter.
  3. Track various events happening in your application.
    It can be anything from uploading new picture to installing new plug-in.
  4. Present user activities on user profile page.
  5. Follow friends activities.
  6. Present configurable newsfeed, which shows timeline of events happening in the app."
desc
end
