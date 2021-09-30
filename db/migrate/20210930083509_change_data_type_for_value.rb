class ChangeDataTypeForValue < ActiveRecord::Migration[6.1]
  def change
    change_column :metric_values, :value, :decimal, precision: 10, scale: 2
  end
end
