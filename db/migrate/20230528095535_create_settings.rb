class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :color, default: 'NA', null: false
      t.string :method, default: 'NA', null: false
      t.references :image, foreign_key: true

      t.timestamps
    end
  end
end
