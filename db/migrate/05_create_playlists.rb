class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
