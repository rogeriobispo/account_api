require 'rails_helper'

RSpec.describe Api::V1::ClientsController, type: :request do
  before do
    @legal_person_param = { person: {
      name: FFaker::Lorem.word,
      cnpj: CNPJ.generate,
      social_reason: FFaker::Lorem.word
    } }

    @invalid_legal_person_param = { person: { name: nil, cnpj: nil,
                                              social_reason: nil } }
    @physical_person_param = { person: {
      name: FFaker::Lorem.word,
      cpf: CPF.generate,
      birthdate: '1983-08-11'
    } }

    @invalid_physical_person_param = { person: { name: nil,
                                                 cpf: nil, birthdate: nil } }

    @legal_person = create(:client, :leg_person)
    @physical_person = create(:client, :phy_person)
  end

  describe 'post #create' do
    context 'create a legal person' do
      it 'successfully' do
        post '/api/v1/clients', params: @legal_person_param
        parsed_response = JSON.parse(response.body)
        lc = Client.last
        expect(parsed_response['id']).to eq(lc.id)
        expect(parsed_response['name']).to eq(lc.name)
      end

      it 'failed create' do
        post '/api/v1/clients', params: @invalid_legal_person_param
        expect(response.status).to eq(422)
      end
    end

    context 'create a physical person' do
      it 'successfully' do
        post '/api/v1/clients', params: @physical_person_param
        parsed_response = JSON.parse(response.body)
        lc = Client.last
        expect(parsed_response['id']).to eq(lc.id)
        expect(parsed_response['name']).to eq(lc.name)
      end

      it 'failed create' do
        post '/api/v1/clients', params: @invalid_legal_person_param
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'patch/put #UPDATE' do
    context 'update a legal person' do
      it 'successfully' do
        client = @legal_person
        hash_param = { person: { id: client.id,
                                 social_reason: client.person.social_reason,
                                 name: 'Rogério Bispo ME',
                                 cnpj: '2155' } }
        patch "/api/v1/clients/#{client.id}", params: hash_param
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(client.id)
        expect(parsed_response['name']).not_to eq(client.name)
        expect(parsed_response['name']).to eq('Rogério Bispo ME')
        expect(parsed_response['cnpj']).to eq('2155')
      end
    end

    context 'update a physical person' do
      it 'successfully' do
        client = @physical_person
        hash_param = { person: { id: client.id,
                                 name: 'Rogério Bispo',
                                 cpf: '24411' } }
        patch "/api/v1/clients/#{client.id}", params: hash_param
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(client.id)
        expect(parsed_response['name']).not_to eq(client.name)
        expect(parsed_response['name']).to eq('Rogério Bispo')
        expect(parsed_response['cpf']).to eq('24411')
      end
    end
  end

  describe 'get #SHOW' do
    context 'consult a legal person' do
      it 'sucessfully' do
        person = @legal_person
        get "/api/v1/clients/#{person.id}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(person.id)
        expect(parsed_response['name']).to eq(person.name)
      end
    end

    context 'show a physical person' do
      it 'successfully' do
        person = @physical_person
        get "/api/v1/clients/#{person.id}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(person.id)
        expect(parsed_response['name']).to eq(person.name)
      end
    end
  end

  describe 'delete #destroy' do
    context 'delete a legal person' do
      it 'successfully' do
        person = @legal_person
        delete "/api/v1/clients/#{person.id}"
        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_response['id']).to eq(person.id)
        expect(parsed_response['name']).to eq(person.name)
        expect(parsed_response['status']).to eq('deactivated')
      end
    end

    context 'delete a physical person' do
      it 'successfully' do
        person = @physical_person
        delete "/api/v1/clients/#{person.id}"
        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_response['id']).to eq(person.id)
        expect(parsed_response['name']).to eq(person.name)
        expect(parsed_response['status']).to eq('deactivated')
      end
    end
  end
end
