class JoinGameCard < ActiveRecord::Migration[7.0]
  def change
    create_table :cards_games, id: false do |t|
      t.belongs_to :card
      t.belongs_to :game   
    end
  end
end
