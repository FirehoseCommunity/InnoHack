OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :facebook, ENV['236887843371819'], ENV['47aac74bf9486465beefb944abfbfd34']
end