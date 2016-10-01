require File.expand_path('../config/environment', __FILE__)

use Rack::Deflater

Application.load!

run API
