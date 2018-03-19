class PersonService
  def initialize(person_param, update = false, client = nil)
    @person_param = person_param
    @update = update
    @client = client
  end

  def call
    if @update
      update_person
    else
      create_person
    end
  end

  private

  def physical_person?
    @person_param.include?(:cpf)
  end

  def create_physical_person
    PhysicalPerson.create(physical_person_hash)
  end

  def physical_person_hash
    {
      cpf: @person_param[:cpf],
      birthdate: @person_param[:birthdate]
    }
  end

  def update_legal_person
    @client.person.update(legal_person_hash)
    @client.tap { |c| c.update(client_hash(@client.person)) }
  end

  def update_physical_person
    @client.person.update(physical_person_hash)
    @client.tap { |c| c.update(client_hash(@client.person)) }
  end

  def create_legal_person
    LegalPerson.create(legal_person_hash)
  end

  def legal_person_hash
    { cnpj: @person_param[:cnpj],
      social_reason: @person_param[:social_reason] }
  end

  def create_client(person)
    Client.create(client_hash(person))
  end

  def client_hash(person)
    { name: @person_param[:name], person: person }
  end

  def create_person
    if physical_person?
      create_client(create_physical_person)
    else
      create_client(create_legal_person)
    end
  end

  def update_person
    if physical_person?
      update_physical_person
    else
      update_legal_person
    end
  end
end
