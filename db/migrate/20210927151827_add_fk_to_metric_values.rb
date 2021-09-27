class AddFkToMetricValues < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :metric_values, :metrics
  end
end
