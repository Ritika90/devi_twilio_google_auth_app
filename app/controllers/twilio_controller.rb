require 'twilio-ruby'
class TwilioController < ApplicationController
  include Webhookable
  skip_before_action :verify_authenticity_token

  def index

  end

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
      r.Play 'http://linode.rabasa.com/cantina.mp3'
    end
    render_twiml response
  end

  def otp_conf
    if session[:code] == params[:otp]
      if User.find(session[:user]).authenticate_otp(params[:otp], drift:60) == true
        @user = User.find(session[:user])
        @user.confirmed_at = Time.now
        @user.confirmation_token = params[:otp]
        @user.save
      end
    end
  end
end
