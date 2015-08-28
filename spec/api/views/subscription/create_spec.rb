require_relative '../../../../apps/api/views/subscription/create'

RSpec.describe Api::Views::Subscription::Create do
  let(:subscription) do
    instance_double('Subscription', {
      id:        1,
      email:     'email@example.com',
      full_name: 'First Last'
    })
  end

  let(:exposures) { Hash[subscription: subscription] }
  let(:view)      { described_class.new(nil, exposures) }
  let(:rendered)  { view.render }

  it "exposes subscription" do
    expect(view.subscription).to eq exposures.fetch(:subscription)
  end

  describe '#render' do
    it 'returns JSON' do
      expect { JSON.parse(rendered) }.to_not raise_error
    end

    it 'has proper attributes' do
      obj = JSON.parse(rendered, symbolize_names: true)[:subscription]

      expect(obj[:id]).to eq(1)
      expect(obj[:email]).to eq('email@example.com')
      expect(obj[:name]).to eq('First Last')
    end
  end
end
