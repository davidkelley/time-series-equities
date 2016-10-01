describe EquitiesRelation do
  include_context 'dynamo' do
    let(:table_name) { Table::EQUITIES_TABLE_NAME }
    let(:table) { build(:equities_table) }
  end

  let(:orm) { ROM.env }

  let(:ticker) { ('a'..'z').to_a.sample(rand(2..4)).join }

  let(:rel) { orm.relation(:equities) }

  let(:equities_count) { rand(10..20) }

  let(:equities) { build_list(:equity, equities_count, ticker: ticker) }

  before { equities.each { |equity| orm.command(:equities).as(:equity).create.call(equity) } }

  describe '#by_ticker' do
    specify { expect(rel.by_ticker(ticker).to_a.size).to eq equities_count }

    describe 'response ordering (ascending)' do
      let(:response) { rel.by_ticker(ticker).by_ascending }

      let(:ascending_order) {
        derive = response.to_a.each_cons(2).map { |a, b| b['updated_at'] <=> a['updated_at'] }
        derive.all? { |v| v >= 0 }
      }

      specify { expect(ascending_order).to be_truthy }
    end

    describe 'response ordering (descending)' do
      let(:response) { rel.by_ticker(ticker).by_descending }

      let(:ascending_order) {
        derive = response.to_a.each_cons(2).map { |a, b| b['updated_at'] <=> a['updated_at'] }
        derive.all? { |v| v <= 0 }
      }

      specify { expect(ascending_order).to be_truthy }
    end

    describe 'pagination of data' do
      let(:after_time) { (Time.now.utc - 3600).to_i }

      let(:limit) { (equities_count / 1.5).ceil }

      let(:response) {
        rel.as(:equity)
           .by_ticker(ticker)
           .by_ascending
           .per_page(limit)
           .after(:updated_at, after_time)
      }

      let(:last_evaluated_key) { response.pager.last_evaluated_key }

      specify { expect(response.to_a.size).to eq limit }

      specify { expect(last_evaluated_key.keys).to include "ticker", "updated_at" }

      describe 'second page' do
        let(:second_page) { response.offset(last_evaluated_key) }

        specify { expect(response.to_a.size).to be_within(2).of(limit) }

        specify { expect(second_page.pager.last_evaluated_key).to be_nil }
      end
    end
  end

  describe 'when time is 2 days ago' do
    let(:time) { (Time.now.utc - 3600 * 48).to_i }

    specify { expect(rel.by_ticker(ticker).before(:updated_at, time).to_a.size).to eq 0 }
  end

  describe 'when time is 2 days ahead' do
    let(:time) { (Time.now.utc + 3600 * 48).to_i }

    specify { expect(rel.by_ticker(ticker).after(:updated_at, time).to_a.size).to eq 0 }
  end
end
