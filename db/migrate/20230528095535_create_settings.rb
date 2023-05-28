class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :color, default: 'RED_BLUE', null: false
      t.string :method, default: 'KOCH_SNOWFLAKE', null: false
      t.references :image, foreign_key: true

      t.timestamps
    end
  end
end
