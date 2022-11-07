class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.string :description
      t.string :author
      t.integer :likes, null: false, default: 0
      t.integer :author_id, null: false

      t.timestamps
    end
  end
end
