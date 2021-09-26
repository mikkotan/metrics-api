module Api
  module V1
    class MetricsController < ApplicationController
      def index
        result = Metrics::Transactions::List.new.call
        handle_result(result)
      end

      def create
        result = Metrics::Transactions::Create.new.call(hash_params)
        handle_result(result, :created)
      end

      def update
        result = Metrics::Transactions::Update.new.call(hash_params)
        handle_result(result)
      end

      def destroy
        result = Metrics::Transactions::Destroy.new.call(hash_params[:id])
        handle_result(result)
      end
    end
  end
end
