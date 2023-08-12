class CreatePlayerCards < ActiveRecord::Migration[7.0]
  def change
    create_table :player_cards do |t|

      t.belongs_to :player, foreign_key: true
      t.belongs_to :card, foreign_key: true

      t.timestamps
    end
  end
end
