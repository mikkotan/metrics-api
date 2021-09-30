require 'rails_helper'

RSpec.describe 'Metric Values API', type: :request do
  let!(:metric) { create(:metric, name: 'Network Requests') }
  let!(:values) do
    create_list(
      :metric_value,
      5,
      metric: metric,
      value: 70,
      timestamp: DateTime.now
    )
  end
  let!(:past_seven_days_value) do
    create(
      :metric_value,
      metric: metric,
      timestamp: DateTime.now - 14.days
    )
  end
  let(:metric_id) { metric.id }
  let(:value_id) { values.first.id }

  describe 'GET /api/v1/metrics/:metric_id/values' do
    context 'when parent metric exists' do
      context 'and query params not specified' do
        before { get "/api/v1/metrics/#{metric_id}/values" }

        it 'returns metric values' do
          expect(json['list']).not_to be_empty
          expect(json['list'].size).to eq 6
        end
  
        it 'return status 200' do
          expect(response).to have_http_status 200
        end
      end

      context 'and query params are specified' do
        let(:params) {
          {
            query: {
              from: (DateTime.now - 7.days).beginning_of_day,
              to: DateTime.now.end_of_day
            }
          }
        }

        before { get "/api/v1/metrics/#{metric_id}/values", params: params }

        it 'should filter by timestamp' do
          expect(response).to have_http_status 200
          expect(json['list'].size).to eq 5
        end

        it 'should return average object' do
          avg = json['average']

          expect(avg).not_to be_empty
          expect(avg['per_minute']).to eq '0.0347'
          expect(avg['per_hour']).to eq '2.08'
          expect(avg['per_day']).to eq '50.0'
        end
      end
    end

    context 'when parent metric does not exists' do
      before { get '/api/v1/metrics/none-existing-uuid/values' }

      it 'return status 404' do
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'POST /api/v1/metrics/:metric_id/values' do
    let(:params) { { timestamp: DateTime.now + 1.minute, value: 3 } }

    context 'when params are valid' do
      before { post "/api/v1/metrics/#{metric_id}/values", params: params }

      it 'returns the created metric value record' do
        expect(json['value'].to_i).to eq params[:value]
        expect(metric.values.size).to eq 7
      end

      it 'return status 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when params are invalid' do
      before do
        post "/api/v1/metrics/#{metric_id}/values", params: params.except(:value)
      end

      it 'return status 422' do
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'DELETE /api/v1/metrics/:metric_id/values/:id' do
    context 'when value exists' do
      before { delete "/api/v1/metrics/#{metric_id}/values/#{value_id}" }

      it 'deletes the metric value record' do
        deleted_value = MetricValue.where(id: value_id).limit(1).first

        expect(metric.values.size).to eq 5
        expect(deleted_value).to eq nil
      end

      it 'return status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when value does not exist' do
      before { delete "/api/v1/metrics/#{metric_id}/values/yet-another-none-existing-uuid" }

      it 'returns status 404' do
        expect(response).to have_http_status 404
      end
    end
  end
end