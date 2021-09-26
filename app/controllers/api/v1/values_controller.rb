module Api
  module V1
    class ValuesController < ApplicationController
      before_action :find_metric
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def index
        values = @metric.values
        render json: values, status: :ok
      end

      def create
        value = @metric.values.new(value_params)

        if value.save
          render json: value, status: :created
        else
          render json: value.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        value = @metric.values.find params[:id]
        value.destroy
        head :no_content
      end

      private

      def value_params
        params.permit(:timestamp, :value)
      end

      def find_metric
        @metric = Metric.find params[:metric_id]
      end

      def render_not_found
        render json: 'Record not found', status: :not_found
      end
    end
  end
end
