class Card < ApplicationRecord
    
    enum pinta: [:oro, :espada, :basto, :copa ]
    
    belongs_to :game, optional: true

    has_many :player_cards, dependent: :destroy
    has_many :players, through: :player_cards
    
end
