class CreateEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluations do |t|
      t.references :presentation_id, null: false, foreign_key: { to_table: :presentations }
      t.references :evaluator_id, null: false, foreign_key: { to_table: :users }
      t.float :score
      t.string :comment

      t.timestamps
    end
  end
end
