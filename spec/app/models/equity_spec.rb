describe Equity do
  subject(:equity) { build(:equity) }

  %i(ticker updated_at high low last volume change bid ask).each do |key|
    describe "##{key}" do
      it { should respond_to(key) }

      it { should_not respond_to(:"#{key}=") }
    end
  end

  %i(high low last change bid ask).each do |price|
    describe "##{price} Float" do
      subject { equity.send(price) }

      it { should be_a Float }

      it { should be > 0 }
    end
  end

  specify { expect(subject.high).to be > subject.low }

  specify { expect(subject.ask).to be > subject.bid }

  describe '#ticker' do
    subject { equity.ticker }

    it { should be_a String }

    it { should match /[a-z]+/i }

    specify { expect(subject.size).to be > 0 }
  end
end
