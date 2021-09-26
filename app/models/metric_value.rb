class MetricValue < ApplicationRecord
  belongs_to :metric
  validates_presence_of :value, :timestamp
end
