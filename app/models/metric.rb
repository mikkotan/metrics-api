class Metric < ApplicationRecord
  has_many :values, class_name: "MetricValue"
end
