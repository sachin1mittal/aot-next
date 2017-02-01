OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '81678351527-d63p5jf1p0jvo810q8q5l2ii007ut2t5.apps.googleusercontent.com', 'RDDPLL20jNUbtg0jEidRIPjd', {
    scope: 'email,profile'
  }
  provider :facebook, '1364333446973754', 'b914375c2c9e11b27c4bf1cc27f904a5'
end
