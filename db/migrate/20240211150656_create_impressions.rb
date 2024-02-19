class CreateImpressions < ActiveRecord::Migration[6.1]
  def change
    create_table :impressions do |t|

      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
