require 'rails_helper'

RSpec.describe 'Metrics API', type: :request do
  let!(:metrics) { create_list(:metric, 5) }
  let(:metric_id) { metrics.last.id }

  describe 'GET /api/v1/metrics' do
    before { get '/api/v1/metrics' }

    it 'returns metrics' do
      expect(json).not_to be_empty
      expect(json.size).to eq 5
      expect(json.last['id']).to eq metric_id
    end

    it 'returns status 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /api/v1/metrics' do
    let(:params) { { name: 'CPU Utilization'} }

    context 'when params are valid' do
      before { post '/api/v1/metrics', params: params }

      it 'return created metric' do
        expect(json['name']).to eq params[:name]
      end

      it 'return status 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when params are invalid' do
      before { post '/api/v1/metrics', params: params.except(:name) }

      it 'returns status 422' do
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PUT /api/v1/metrics/:id' do
    let(:update_params) { { name: 'CPU Visualization' } }

    context 'when metric is found' do
      before { put "/api/v1/metrics/#{metric_id}", params: update_params }

      it 'returns updated metric' do
        expect(json['name']).to eq update_params[:name]
      end

      it 'return status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when metric is not found' do
      before { put '/api/v1/metrics/not-valid-uuid', params: update_params }

      it 'return status 404' do
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'DELETE /api/v1/metrics/:id' do
    before { delete "/api/v1/metrics/#{metric_id}" }

    it 'deletes the metric' do
      metrics_count = Metric.all.count
      expect(metrics_count).to eq 4
    end

    it 'return status 204' do
      expect(response).to have_http_status 204
    end
  end
end