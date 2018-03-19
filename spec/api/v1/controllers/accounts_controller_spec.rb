require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :request do
  before do
    client = create(:client)
    @account_param = { account: {
      kind: 'parent_account',
      status: 'active',
      client_id: client.id,
      amount_holded: 10.0
    } }

    @invalid_account = { account: {
      kind: 'parent_account',
      status: 'active',
      client_id: 'A',
      amount_holded: 10.0
    } }
  end

  describe 'post #create' do
    context 'create a account' do
      it 'successfully' do
        post '/api/v1/accounts', params: @account_param
        parsed_response = JSON.parse(response.body)
        ac = Account.last
        expect(parsed_response['id']).to eq(ac.id)
        expect(parsed_response['client_id']).to eq(ac.client_id)
      end

      it 'failed create' do
        post '/api/v1/accounts', params: @invalid_account
        expect(response.status).to eq(422)
      end
    end

    context 'update a physical person' do
      it 'successfully' do
        account = create(:account)
        client = create(:client)
        hash_param = { account: { id: account.id,
                                  kind: 'parent_account',
                                  status: 'canceled',
                                  amount_holded: 5.0,
                                  client_id: client.id } }
        patch "/api/v1/accounts/#{account.id}", params: hash_param
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(account.id)
        expect(parsed_response['kind']).to eq('parent_account')
        expect(parsed_response['status']).to eq('canceled')
        expect(parsed_response['amount_holded']).to eq(5.0.to_s)
        expect(parsed_response['client_id']).to eq(client.id)
      end
    end
  end

  describe 'get #SHOW' do
    context 'consult an account' do
      it 'sucessfully' do
        account = create(:account)
        get "/api/v1/accounts/#{account.id}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(account.id)
        expect(parsed_response['client_id']).to eq(account.client_id)
      end
    end
  end
end
