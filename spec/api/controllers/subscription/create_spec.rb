require_relative '../../../../apps/api/controllers/subscription/create'

RSpec.describe Api::Controllers::Subscription::Create do
  let(:action) { Api::Controllers::Subscription::Create.new }

  after do
    SubscriptionRepository.clear
  end

  context 'when params are valid' do
    let(:params) do
      {
        subscription: {
          first_name: 'test',
          last_name: 'last',
          email: 'email@example.com'
        }
      }
    end

    it "is successful" do
      response = action.call(params)
      expect(response[0]).to eq 200
    end

    it 'exposes subscription with proper attributes' do
      action.call(params)

      subscription = SubscriptionRepository.find_by_email('email@example.com')

      expect(action.subscription).to eq(subscription)
      expect(action.subscription.confirmed_at).to be_nil
    end
  end

  context 'unpermitted params' do
    let(:params) do
      {
        subscription: {
          first_name: 'test',
          last_name: 'last',
          email: 'email@example.com',
          confirmed_at: DateTime.now,
        }
      }
    end

    it 'are ignored' do
      action.call(params)
      subscription = action.subscription

      expect(subscription.confirmed_at).to be_nil
    end
  end

  context 'when subscription is missing' do
    let(:params) { {} }

    it "is not successful" do
      response = action.call(params)
      expect(response[0]).to eq 422
    end
  end
end
