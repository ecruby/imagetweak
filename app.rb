require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'lib/mutable_image'
require 'haml'
require 'sass/plugin/rack'
use Sass::Plugin::Rack

get '/' do
  haml :index
end

get '/image.png' do
  send_file 'tmp/image.png', :disposition => 'inline'
end

post '/' do
  @image = MutableImage.new(params[:image_url])
  @image.send(params[:task]) if params[:task]
  @generated = @image.save_to('tmp/image.png')
  haml :index
end
