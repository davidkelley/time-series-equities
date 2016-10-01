# Simple module that exposes the static #ROM.env method to classes via a
# simple method. This module should be used as a mixin whenever a class
# requires Database & Gateway connectivity.
module OrmHelper
  # Returns the finalized ROM Environment. This includes all defined
  # gateways and supported relations and mappers. It is the primary
  # entrypoint for all classes and objects to access the database.
  def orm
    ROM.env
  end
end
