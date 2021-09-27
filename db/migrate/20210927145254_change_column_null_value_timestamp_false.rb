class ChangeColumnNullValueTimestampFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_null :metric_values, :value, false
    change_column_null :metric_values, :timestamp, false
  end
end
