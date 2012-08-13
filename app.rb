require "rubygems"
require "bundler/setup"

Bundler.require(:default)

configure do
  set :public_folder, File.join(settings.local_dir, 'public')
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
