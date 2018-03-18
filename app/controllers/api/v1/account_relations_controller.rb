module Api
  module V1
    class AccountRelationsController < ApiController
      before_action :set_account_relation, only: [:destroy]
      def create
        acc_relation = AccountRelation.new(ac_relation_params)
        if acc_relation.save
          render json: acc_relation
        else
          render json: acc_relation.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @account_relation.destroy
        render json: true
      end

      private

      def ac_relation_params
        params.require(:account_relation).permit(:parent_account_id, :subsidiary_account_id)
      end

      def set_account_relation
        @account_relation = AccountRelation.find(params[:id])
      end
    end
  end
end
