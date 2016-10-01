# Provides a Domain specific wrapper for environment variables that would
# otherwise be referenced throughout the entire application. Which would
# be ugly as sin.
module Table
  # The name of the table where equities are stored.
  #
  # @note This field is required. There is no default.
  #
  # @return [symbol] Symbolised version of the table name
  EQUITIES_TABLE_NAME = ENV['EQUITIES_TABLE_NAME'].to_sym
end
