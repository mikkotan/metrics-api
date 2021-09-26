module Api
  module V1
    class ValuesController < ApplicationController
      before_action :find_metric

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

      def find_metric
        @metric = Metric.find params[:metric_id]
      end
    end
  end
end
