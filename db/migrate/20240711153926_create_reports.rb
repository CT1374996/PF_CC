class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reporter_id, null: false
      t.integer :reported_id, null: false
      t.text :reason, null: false
      t.text :url
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
