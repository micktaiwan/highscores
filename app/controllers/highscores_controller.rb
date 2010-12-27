class HighscoresController < ApplicationController

  protect_from_forgery :except => [:create]

  def index
    @last       = Highscore.find(:all, :order=>"created_at desc", :limit=>20)
  end

  def create
    game    = params[:game]
    level   = params[:level]
    player  = params[:player]
    score   = params[:score]
    game_id = Game.find_by_name(game)
    game_id = Game.create(:name=>game).id if not game_id
    Highscore.create(:game_id=>game_id, :level=>level, :player=>player, :score=>score)
    redirect :action=>index
  end

end

