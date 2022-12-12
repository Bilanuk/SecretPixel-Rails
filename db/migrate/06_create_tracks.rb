class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.references :user, foreign_key: true, null: false, index: true
      t.references :playlist, foreign_key: true, null: true, index: true

      t.timestamps
    end
  end
end
