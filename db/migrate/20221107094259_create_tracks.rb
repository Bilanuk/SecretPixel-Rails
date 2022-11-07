class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :description
      t.string :author
      t.integer :likes
      t.integer :author_id

      t.timestamps
    end
  end
end
