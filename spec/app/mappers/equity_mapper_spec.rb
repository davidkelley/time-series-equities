describe EquityMapper do
  include_context 'dynamo' do
    let(:table_name) { Table::EQUITIES_TABLE_NAME }
    let(:table) { build(:equities_table) }
  end

  let(:orm) { ROM.env }

  let(:ticker) { ('a'..'z').to_a.sample(rand(2..4)).join }

  let(:equity) { build(:equity, ticker: ticker) }

  before { orm.command(:equities).as(:equity).create.call(equity) }

  subject(:rel) { orm.relation(:equities) }

  describe 'return value' do
    let(:sample) { subject.as(:equity).by_ticker(ticker).one! }

    specify { expect(sample).to be_an_instance_of Equity }
  end

  describe 'mapped keys' do
    let(:raw) { subject.by_ticker(ticker).one! }

    let(:sample) { subject.as(:equity).by_ticker(ticker).one! }

    specify { expect(sample.ticker).to eq raw['ticker'] }

    specify { expect(sample.updated_at).to eq raw['updated_at'].to_f }

    specify { expect(sample.high).to eq raw['high'].to_f }

    specify { expect(sample.low).to eq raw['low'].to_f }

    specify { expect(sample.last).to eq raw['last'].to_f }

    specify { expect(sample.volume).to eq raw['volume'].to_i }

    specify { expect(sample.change).to eq raw['change'].to_f }

    specify { expect(sample.bid).to eq raw['bid'].to_f }

    specify { expect(sample.ask).to eq raw['ask'].to_f }
  end
end
