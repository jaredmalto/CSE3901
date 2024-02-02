class RemoveAndAddColumnsEvaluations < ActiveRecord::Migration[7.0]
  def change
    remove_column :evaluations, :score
    add_column :evaluations, :organization_score, :integer
    add_column :evaluations, :content_score, :integer
    add_column :evaluations, :visuals_score, :integer
    add_column :evaluations, :delivery_score, :integer
  end
end
