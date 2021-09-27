class AddUniqueConstraintToName < ActiveRecord::Migration[6.1]
  def change
    add_index :metrics, :name, unique: true
  end
end
