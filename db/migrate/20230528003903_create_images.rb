class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, default: 'image.bmp', null: false

      t.timestamps
    end
  end
end
