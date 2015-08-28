RSpec.describe 'Subscription signup', type: :api do
  before do
    header 'Accept', 'application/json'
  end

  after do
    SubscriptionRepository.clear
  end

  let(:subscription_params) do
    { subscription: params }
  end

  context 'when params are valid' do
    let(:params) do
      {
        first_name: 'Mike',
        last_name:  'Example',
        email: 'mike@example.com'
      }
    end

    it 'responds with 200 OK' do
      post '/subscribe', subscription_params

      expect(last_response).to be_ok
    end

    it 'responds with user params' do
      post '/subscribe', subscription_params

      subscription = SubscriptionRepository.find_by_email('mike@example.com')

      json_response = JSON.parse(last_response.body, symbolize_names: true)
      expect(json_response).to eq( {
        subscription: {
          id: subscription.id,
          email: 'mike@example.com',
          name: 'Mike Example'
        }
      })
    end

    it 'creates Subscription in database' do
      expect {
        post '/subscribe', subscription_params
      }.to change { SubscriptionRepository.all.count}.by(1)
    end

    describe 'persisted subscription' do
      before do
        post '/subscribe', subscription_params
      end

      subject { SubscriptionRepository.find_by_email('mike@example.com') }

      it 'persists proper attributes' do
        expect(subject.id).to_not be_nil
        expect(subject.first_name).to eq('Mike')
        expect(subject.last_name).to eq('Example')
        expect(subject.email).to eq('mike@example.com')
        expect(subject.created_at).to_not be_nil
        expect(subject.confirmed_at).to be_nil
      end
    end
  end

  context 'when params are invalid' do
    let(:params) do
      { email: 'test@example.com' }
    end

    it 'does not persist subscription' do
      expect {
        post '/subscribe', subscription_params
      }.to_not change { SubscriptionRepository.all.count}
    end

    it 'responds with error code' do
      post '/subscribe', subscription_params

      expect(last_response.status).to eq(422)
    end

    it 'has errors in body' do
      post '/subscribe', subscription_params

      json_response = JSON.parse(last_response.body, symbolize_names: true)

      expect(json_response).to have_key(:errors)
      expect(json_response[:errors][:'subscription.first_name']).to eq(['presence'])
    end
  end
end
