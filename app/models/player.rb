class Player < ApplicationRecord
    has_secure_password 

    validates :username, presence: true, uniqueness: true 
    validates :password, :password_confirmation, presence: true

    
    
    has_many :player_games, dependent: :destroy
    has_many :games, through: :player_games
    
    
    
    has_many :player_cards, dependent: :destroy
    has_many :cards, through: :player_cards
   

end
