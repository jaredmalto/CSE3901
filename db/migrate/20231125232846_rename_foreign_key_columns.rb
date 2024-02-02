class RenameForeignKeyColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :enrollments, :user_id_id, :user_id
    rename_column :enrollments, :presentation_id_id, :presentation_id
    
    rename_column :evaluations, :evaluator_id_id, :evaluator_id
    rename_column :evaluations, :presentation_id_id, :presentation_id
    
    rename_column :presentations, :user_id_id, :user_id
  end
end
