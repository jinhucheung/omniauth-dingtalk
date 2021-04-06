require 'bundler'
require 'sinatra'
require 'omniauth'
require_relative '../lib/omniauth_dingtalk'


ENV['APPID'] = 'APPID'
ENV['APPSECRET'] = 'APPSECRET'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/dingtalk'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    puts MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie, secret: 'change_me'

use OmniAuth::Builder do
  # note that the scope is different from the default
  # we also have to repeat the default fields in order to get
  # the extra 'connections' field in there
  provider :dingtalk, ENV['APPID'], ENV['APPSECRET']
end

run App.new
