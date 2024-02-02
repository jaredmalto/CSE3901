class CreatePresentations < ActiveRecord::Migration[7.0]
  def change
    create_table :presentations do |t|
      t.string :title
      t.string :description
      t.date :date
      t.references :user_id, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
