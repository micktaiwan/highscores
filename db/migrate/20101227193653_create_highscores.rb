class CreateHighscores < ActiveRecord::Migration
  def self.up
    create_table :highscores do |t|
      t.integer :game_id
      t.integer :level
      t.string  :player
      t.float   :score
      t.timestamps
    end
  end

  def self.down
    drop_table :highscores
  end
end

