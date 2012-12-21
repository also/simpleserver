require "rubygems"
require "bundler/setup"

Bundler.require(:default)

configure do
  public_folder = File.join settings.local_dir, 'public'
  public_folder = settings.local_dir unless File.exist? public_folder
  set :public_folder, public_folder
  sprockets = Sprockets::Environment.new
  sprockets.append_path settings.public_folder
  set :sprockets, sprockets
end

get '/*' do |path|
  path
  asset = settings.sprockets[path]
  unless asset.nil?
    content_type asset.content_type
    asset
  else
    pass
  end
end
