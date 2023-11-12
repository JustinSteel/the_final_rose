class AddIndexToContestantOutings < ActiveRecord::Migration[7.0]
  def change
    add_index :contestant_outings, :contestant_id
    add_index :contestant_outings, :outing_id
  end
end
