class EquityMapper < ROM::Mapper
  relation :equities

  register_as :equity

  model Equity
end
