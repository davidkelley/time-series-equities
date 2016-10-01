# Provides a mount for the Grape API. Rack uses this class to map requests
# to responses.
class API < Grape::API
  mount EquitiesController => '/'

  mount PingController => '/ping'
end
