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

  def level
    game    = params[:game]
    if game != nil
      game_id = Game.find_by_name(game)
    else
      game_id = Game.find(params[:game_id])
    end
    level   = params[:level]
    @game = game_id.name
    @level = level
    @scores = Highscore.find(:all, :conditions=>["game_id=? and level=?", game_id, level], :order=>"score", :limit=>1000)
  end

  def game
    game    = params[:game]
    if game != nil
      game_id = Game.find_by_name(game)
    else
      game_id = Game.find(params[:game_id])
    end
    @game = game_id.name
    @scores = Highscore.find(:all, :select=>"*, sum(score)/count(*) s", :conditions=>["game_id=?", game_id], :order=>"s", :limit=>1000, :group=>"player")
  end

end

