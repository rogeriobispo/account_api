module Api
  module V1
    class AportsController < ApiController
      before_action :set_aport, only: [:show]
      before_action :aport_by_code, only: [:revert]

      def create
        aport = AportService.new(aport_params).call
        if aport.valid?
          render json: { aport: aport, transaction: aport.account_transaction }
        else
          render json: aport.errors, status: :unprocessable_entity
        end
      end

      def show
        transaction = @aport.account_transaction
        render json: { aport: @aport, transaction: transaction } if @aport
      end

      def revert
        if @aport.present? && will_reverse?
          ac_transaction = @aport.account_transaction
          render json: { aport: @aport, transaction: ac_transaction }
        else
          message = 'Failed checke account balance and rules'
          render json: { message: message }, status: :unprocessable_entity
        end
      end

      private

      def aport_params
        params.require(:account_transaction)
              .permit(ac_transaction: [:origin_account_id,
                                       :destiny_account_id,
                                       :amount],
                      aport: [:code])
      end

      def set_aport
        @aport = Aport.find(params[:id])
      end

      def aport_by_code
        @aport = Aport.where(code: params[:code]).last
      end

      def will_reverse?
        @aport.account_transaction.created? &&
          @aport.account_transaction.reverse?
      end
    end
  end
end
