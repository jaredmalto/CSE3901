class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :user_id, null: false, foreign_key: { to_table: :users }
      t.references :presentation_id, null: false, foreign_key: { to_table: :presentations }

      t.timestamps
    end
  end
end
