require 'rails_helper'

RSpec.describe Metrics::Transactions::Destroy do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'First Metric') }
    let(:metric_id) { metric.id }

    it 'deletes the metric record' do
      result = subject.call(metric_id)
      deleted_metric_id = result.success[:deleted_metric_id]
      deleted_metric = Metric.where(id: deleted_metric_id).limit(1).first

      expect(result).to be_success
      expect(deleted_metric_id).to eq metric_id
      expect(deleted_metric).to eq nil
    end
  end
end
