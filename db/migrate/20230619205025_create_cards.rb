class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|

      t.integer :numero
      t.column :pinta, :integer
      #t.belongs_to :game, foreign_key: true, null: true
      t.timestamps
    end  
  end
end
