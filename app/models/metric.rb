class Metric < ApplicationRecord
  validates_presence_of :name
  has_many :values, class_name: "MetricValue"
end
