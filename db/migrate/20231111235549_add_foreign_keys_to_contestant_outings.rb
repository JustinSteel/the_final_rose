class AddForeignKeysToContestantOutings < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :contestant_outings, :contestants
    add_foreign_key :contestant_outings, :outings
  end
end
