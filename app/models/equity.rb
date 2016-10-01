class Equity
  class Entity < EquityEntity
  end

  include ValueObject

  values do
    attribute :ticker, String
    attribute :updated_at, Float, default: -> (*_) { Time.now.utc.to_f }
    attribute :high, Float, default: nil
    attribute :low, Float, default: nil
    attribute :last, Float, default: nil
    attribute :volume, Float, default: nil
    attribute :change, Float, default: nil
    attribute :bid, Float, default: nil
    attribute :ask, Float, default: nil
  end
end
