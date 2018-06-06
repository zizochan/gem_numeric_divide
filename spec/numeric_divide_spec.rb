RSpec.describe NumericDivide do
  it "has a version number" do
    expect(NumericDivide::VERSION).not_to be nil
  end

  describe "#divide" do
    subject { numeric.divide(separation, include_start: include_start, include_end: include_end) }

    let(:numeric)       { 100 }
    let(:separation)    { 30 }
    let(:include_start) { false }
    let(:include_end)   { true }

    it { is_expected.to eq [30, 60, 90, 100] }

    context "when include_start is true" do
      let(:include_start) { true }
      it { is_expected.to eq [0, 30, 60, 90, 100] }
    end

    context "when include_end is false" do
      let(:include_end) { false }
      it { is_expected.to eq [30, 60, 90] }
    end

    context "when divided last value == numeric" do
      let(:numeric) { 90 }
      it "end value isn't duplicated" do
        is_expected.to eq [30, 60, 90]
      end
    end

    context "when numeric is Float" do
      let(:numeric) { 80.5 }
      it { is_expected.to eql [30.0, 60.0, 80.5] }
    end

    context "when separation is Float" do
      let(:separation) { 30.5 }
      it { is_expected.to eql [30.5, 61.0, 91.5, 100.0] }
    end

    context "when numeric is negative" do
      let(:numeric) { -1 }
      it { is_expected.to eq [] }
    end

    context "when numeric is zero" do
      let(:numeric) { 0 }
      it { expect { subject }.to_not raise_error }
    end

    context "when separation is negative" do
      let(:separation) { -1 }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "when separation is zero" do
      let(:separation) { 0 }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end
end
