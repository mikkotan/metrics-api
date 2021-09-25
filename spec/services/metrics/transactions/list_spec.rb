require 'rails_helper'

RSpec.describe Metrics::Transactions::List do
  describe '#call' do
    let!(:metrics) { create_list(:metric, 5) }

    it 'returns success monad with correct metrics' do
      result = subject.call
      result_metrics = result.success

      expect(result).to be_success
      expect(result_metrics.size).to eq metrics.size
    end
  end
end
