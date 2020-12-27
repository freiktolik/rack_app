require 'pry'

config_files = File.expand_path('../config/**/*.rb',  __FILE__)
app_files = File.expand_path('../app/**/*.rb',  __FILE__)

[config_files, app_files].each do |files|
  Dir.glob(files).each { |file| require(file) }
end

class Application
  def call(env)
    request = Rack::Request.new(env)
    serve_request(request)
  end

  def serve_request(request)
    Routes.new(request).route!
  end
end