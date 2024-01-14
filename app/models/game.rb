class Game < ApplicationRecord
    enum estado: [:espera, :en_curso, :terminado ]

  
    belongs_to :player

    has_many :player_games, dependent: :destroy
    has_many :players, through: :player_games
    
    #has_many :cards, dependent: :destroy

    has_and_belongs_to_many :cards

    
    def assign_cards(cards)
        self.cards << cards
    end

end
