module Api
  module V1
    class MetricsController < ApplicationController
      before_action :find_metric, only: [:update, :destroy]

      def index
        metrics = Metric.all
        render json: metrics, status: :ok
      end

      def create
        metric = Metric.new(metric_params)

        if metric.valid?
          render json: metric, status: :created
        else
          render json: { error: metric.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @metric.update(metric_params)
          render json: @metric, status: :ok
        else
          render json: { error: metric.errors.full_message }, status: :unprocessable_entity
        end
      end

      def destroy
        @metric.destroy
        head :no_content
      end

      private

      def metric_params
        params.permit(:name)
      end

      def find_metric
        @metric = Metric.find(params[:id])

      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Metric not found' }, status: :not_found
      end
    end
  end
end
