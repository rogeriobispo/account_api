module Api
  module V1
    class ClientsController < ApiController
      before_action :set_person, only: [:destroy, :show, :update]
      def create
        client = PersonService.new(person_params).call
        if client.valid?
          render json: client.person.formated_person.to_json
        else
          render json: client.person.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @client.person.formated_person if @client
      end

      def destroy
        @client.deactivated!
        render json: @client
      end

      def update
        client = PersonService.new(person_params, true, @client).call
        if client.valid?
          render json: client.person.formated_person.to_json
        else
          render json: client.person.errors, status: :unprocessable_entity
        end
      end

      private

      def person_params
        params.require(:person).permit(:name, :cnpj, :cpf,
                                       :social_reason, :birthdate)
      end

      def set_person
        @client = Client.find(params[:id])
      end

    end
  end
end
