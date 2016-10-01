class EquityEntity < Grape::Entity
  expose :ticker, :updated_at, :high, :low, :last, :volume, :change, :bid, :ask
end
