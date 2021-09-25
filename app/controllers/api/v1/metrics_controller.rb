module Api
  module V1
    class MetricsController < ApplicationController
      include ErrorHandlers

      def index
        result = Metrics::Transactions::List.new.call

        case result
        in Success(metrics)
          render json: metrics, status: :ok
        else
          handle_bad_request(result)
        end
      end

      def create
        result = Metrics::Transactions::Create.new.call(metric_params)

        case result
        in Success(metric)
          render json: metric, status: :created
        in Failure[:invalid_params, error_messages]
          handle_invalid_params(error_messages)
        end
      end

      def update
        result = Metrics::Transactions::Update.new.call(metric_params)

        case result
        in Success(metric)
          render json: metric, status: :ok
        in Failure[:not_found, message]
          handle_not_found(message)
        in Failure[:invalid_params, error_messages]
          handle_invalid_params(error_messages)
        end
      end

      def destroy
        result = Metrics::Transactions::Destroy.new.call(metric_params[:id])

        case result
        in Success(id)
          render json: { deleted_metric_id: id }, status: :ok
        in Failure[:not_found, message]
          handle_not_found(message)
        end
      end

      private

      def metric_params
        params.to_unsafe_h
      end
    end
  end
end
