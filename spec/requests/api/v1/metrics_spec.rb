require 'rails_helper'

RSpec.describe 'Metrics API', type: :request do
  let!(:metrics) { create_list(:metric, 5) }
  let(:metric_id) { metrics.last.id }

  describe 'GET /api/v1/metrics' do
    before { get api_v1_metrics_path }

    it 'returns metrics' do
      expect(json).not_to be_empty
      expect(json.size).to eq 5
    end

    it 'returns status 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /api/v1/metrics' do
    let(:params) { { name: 'CPU Utilization'} }

    context 'when params are valid' do
      before { post api_v1_metrics_path, params: params }

      it 'return created metric' do
        expect(json['name']).to eq params[:name]
      end

      it 'return status 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when params are invalid' do
      before { post api_v1_metrics_path, params: params.except(:name) }

      it 'returns status 422' do
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'GET /api/v1/metrics/:id' do
    context 'when record exists' do
      before { get api_v1_metric_path(metric_id) }

      it 'returns metric record' do
        expect(json['id']).to eq metric_id
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when record does not exist' do
    end
  end

  describe 'PUT /api/v1/metrics/:id' do
    let(:update_params) { { name: 'CPU Visualization' } }

    context 'when metric is found' do
      before { put api_v1_metric_path(metric_id), params: update_params }

      it 'returns updated metric' do
        expect(json['name']).to eq update_params[:name]
      end

      it 'return status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when metric is not found' do
      before { put api_v1_metric_path('not-valid-uuid'), params: update_params }

      it 'return status 404' do
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'DELETE /api/v1/metrics/:id' do
    before { delete "/api/v1/metrics/#{metric_id}" }

    it 'deletes the metric' do
      deleted_metric = Metric.where(id: metric_id).limit(1).first
      expect(deleted_metric).to eq nil
    end

    it 'return status 200' do
      expect(response).to have_http_status 200
    end
  end
end