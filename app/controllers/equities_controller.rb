class EquitiesController < Grape::API
  default_format :json

  # @!parse include OrmHelper
  helpers OrmHelper

  # @!parse include PaginationHelper
  helpers PaginationHelper

  helpers do
    def to_equity
      Equity.new params
    end
  end

  params do
    requires :ticker, type: String
    optional :before, type: Integer
    requires :after, type: Integer
  end
  get '/' do
    relation = orm.relation(:equities).as(:equity).by_descending
    relation = relation.by_ticker(params.ticker)
    relation = relation.after(:updated_at, params.after)
    relation = relation.between(:updated_at, params.after, params.before) if params.before
    present relation.to_a
  end

  params do
    requires :ticker, type: String
    optional :updated_at, type: Float, default: -> { Time.now.utc.to_f }
    requires :high, type: Float
    requires :low, type: Float
    requires :last, type: Float
    requires :volume, type: Integer
    requires :change, type: Float
    requires :bid, type: Float
    requires :ask, type: Float
  end
  post do
    equity = to_equity
    orm.command(:equities).as(:equity).create.call(equity)
    present equity
  end
end
