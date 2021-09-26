class CreateMetricValues < ActiveRecord::Migration[6.1]
  def change
    create_table :metric_values, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.datetime :timestamp
      t.float :value
      t.references :metric, type: :uuid

      t.timestamps
    end
  end
end
