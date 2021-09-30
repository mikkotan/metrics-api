require 'rails_helper'

RSpec.describe MetricValues::Transactions::List do
  describe '#call' do
    let(:validate_metric) { instance_double(Metrics::Operations::FindById) }
    let(:list) { instance_double(MetricValues::Operations::ListByMetricId) }
    let(:apply_filter) { instance_double(MetricValues::Operations::FilterByTimestamp) }
    let(:get_avg) { instance_double(MetricValues::Operations::GetAverageFromList) }

    let(:list_array) { ['sample', 'list'] }
    let(:avg) { { per_minute: '10', per_hour: '11', per_day: '12' } }
    let(:success_ok) { Dry::Monads::Result::Success.new(:ok) }
    let(:success_array) { Dry::Monads::Result::Success.new(list_array) }
    let(:success_avg) { Dry::Monads::Result::Success.new(avg) }

    let(:subject) do
      described_class.new(
        validate_metric: validate_metric,
        list: list,
        apply_filter: apply_filter,
        get_avg: get_avg
      )
    end
    let(:params) do
      {
        metric_id: 'sample-uuid-1',
        query: {
          from: DateTime.now.beginning_of_day,
          to: DateTime.now.end_of_day
        }
      }
    end

    context 'when params are valid' do
      it 'returns success monad with values' do
        expect(validate_metric).to receive(:call).with(params[:metric_id]) { success_ok }
        expect(list).to receive(:call).with(params[:metric_id]) { success_array }
        expect(apply_filter).to receive(:call).with(list_array, params[:query]) { success_array }
        expect(get_avg).to receive(:call).with(list_array, params[:query]) { success_avg }

        result = subject.call(params)
        expected_entity = MetricValues::Entities::ListWithAverage.new(
          list: list_array,
          average: avg
        )

        expect(result).to be_success
        expect(result.success).to eq expected_entity
      end
    end

    context 'when params are invalid' do
      it 'should return a failure monad with contract level errors' do
        result = subject.call(params.except(:metric_id))
        error, messages = result.failure
  
        expect(result).to be_failure
        expect(error).to eq :invalid_params
        expect(messages[:metric_id]).to include 'is missing'
      end
    end
  end
end