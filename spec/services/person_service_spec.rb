require 'rails_helper'

RSpec.describe AportService, type: :service do
  before do
    ActionController::Parameters.permit_all_parameters = true

    @legal_person_param = ActionController::Parameters.new(
      name: FFaker::Lorem.word,
      cnpj: CNPJ.generate,
      social_reason: FFaker::Lorem.word
    )

    @physical_person_param = ActionController::Parameters.new(
      name: FFaker::Lorem.word,
      cpf: CPF.generate,
      birthdate: '1983-08-11'
    )
  end

  describe '#call' do
    it 'create a legal person' do
      client = PersonService.new(@legal_person_param).call
      expect(client.person.class).to be(LegalPerson)
    end

    it 'create a physical person' do
      client = PersonService.new(@physical_person_param).call
      expect(client.person.class).to be(PhysicalPerson)
    end
  end
end
