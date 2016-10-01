describe EquityEntity do
  subject { EquityEntity }

  it { is_expected.to represent(:ticker) }

  it { is_expected.to represent(:updated_at) }

  it { is_expected.to represent(:high) }

  it { is_expected.to represent(:low) }

  it { is_expected.to represent(:last) }

  it { is_expected.to represent(:volume) }

  it { is_expected.to represent(:change) }

  it { is_expected.to represent(:bid) }

  it { is_expected.to represent(:ask) }
end
