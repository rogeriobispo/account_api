require 'rails_helper'

Rspec.describe Api::V1::TransactionController, type: :request do
  describe 'get #show' do
    it 'returns a list of transactions' do
      get '/api/v1/survivors/1'
      json = JSON.parse(last_response.body)
      expect(json['data']['id']).to eq(1)
    end
  end
end
