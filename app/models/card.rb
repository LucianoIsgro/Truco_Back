class Card < ApplicationRecord
    
    enum pinta: [:oro, :espada, :basto, :copa ]
    
    #belongs_to :game, optional: true
    
    has_and_belongs_to_many :games
   

    has_many :player_cards, dependent: :destroy
    has_many :cards, through: :player_cards
    
end
