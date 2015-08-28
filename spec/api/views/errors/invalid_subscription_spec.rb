require_relative '../../../../apps/api/views/errors/invalid_subscription'

RSpec.describe Api::Views::Errors::InvalidSubscription do
  let(:errors) do
    {
      first:  [double(validation: 'presence')],
      second: [double(validation: 'uniqueness'), double(validation: 'second')]
    }
  end

  let(:exposures) { Hash[errors: errors] }
  let(:view)      { described_class.new(nil, exposures) }
  let(:rendered)  { view.render }

  it 'exposes errors' do
    expect(view.errors).to eq(exposures.fetch(:errors))
  end

  describe '#render' do
    it 'decorates errors' do
      expect { JSON.parse(rendered) }.to_not raise_error
    end

    it 'returns object errors' do
      obj = JSON.parse(rendered, symbolize_names: true)[:errors]

      expect(obj[:first]).to eq(['presence'])
      expect(obj[:second]).to eq(['uniqueness', 'second'])
    end
  end
end

