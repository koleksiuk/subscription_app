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
    end
  end

  context 'unpermitted params' do
    let(:params) do
      {
        subscription: {
          first_name: 'test',
          last_name: 'last',
          email: 'email@example.com',
          created_at: DateTime.new(2000, 1, 1),
        }
      }
    end

    it 'are ignored' do
      action.call(params)
      subscription = action.subscription

      expect(subscription.created_at.to_date).to eq(Date.today)
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
