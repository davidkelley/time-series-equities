class CreateEquity < ROM::Commands::Create[Application::ORM]
  KEYS = %i(ticker updated_at high low last volume change bid ask)

  relation :equities
  register_as :create
  result :one

  input Functions[:accept_keys, KEYS]
end
