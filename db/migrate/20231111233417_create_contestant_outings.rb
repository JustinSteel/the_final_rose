class CreateContestantOutings < ActiveRecord::Migration[7.0]
  def change
    create_table :contestant_outings do |t|
      t.integer :contestant_id
      t.integer :outing_id

      t.timestamps
    end
  end
end
