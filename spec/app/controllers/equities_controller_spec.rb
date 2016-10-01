describe EquitiesController do
  include_context 'dynamo' do
    let(:table_name) { Table::EQUITIES_TABLE_NAME }
    let(:table) { build(:equities_table) }
  end

  let(:orm) { ROM.env }

  let(:rel) { orm.relation(:equities) }

  let(:ticker) { ('a'..'z').to_a.sample(rand(2..4)).join }

  let(:equity_count) { rand(10..20) }

  let(:equities) { build_list(:equity, equity_count, ticker: ticker) }

  before { equities.each { |equity| orm.command(:equities).as(:equity).create.call(equity) } }

  describe 'POST: create equity' do
    let(:root) { '/' }

    let(:equity) { build(:equity, ticker: ticker) }

    before { post root, equity.to_h }

    subject { response }

    specify { expect(json_body[:ticker]).to eq ticker }

    %i(high low last change bid ask).each do |price|
      describe "##{price} Float" do
        subject { json_body[price] }

        it { should be_a Float }

        it { should be > 0 }
      end
    end

    specify { expect_json_types :object }

    specify { expect_status 201 }
  end

  describe 'GET: equities data' do
    let(:root) { '/' }

    let(:after) { Time.now.utc.to_i - 3600 }

    let(:before) { Time.now.utc.to_i + 3600 }

    let(:query) { Rack::Utils.build_nested_query(ticker: ticker, after: after, before: before) }

    before { get "#{root}?#{query}" }

    subject { response }

    it { should_not be_empty }

    specify { expect(json_body).to_not be_empty }

    specify { expect(json_body.length).to eq equities.count }

    specify { expect_json_types :array }

    specify { expect_status 200 }

    describe 'response ordering (descending)' do
      let(:ascending_order) {
        derive = json_body.each_cons(2).map { |a, b| b[:updated_at] <=> a[:updated_at] }
        derive.all? { |v| v <= 0 }
      }

      specify { expect(ascending_order).to be_truthy }
    end
  end
end
