class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :nombre
      t.string :token
      t.column :estado, :integer, default: 0

      t.belongs_to :player, foreign_key: true
      t.timestamps
    end
  end
end
