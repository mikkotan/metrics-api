class ChangeColumnNullNameFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_null :metrics, :name, false
  end
end
