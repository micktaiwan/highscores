class HighscoresController < ApplicationController

  protect_from_forgery :except => [:create, :delete_level_scores]

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
    render(:nothing=>true)
  end

  def level
    game    = params[:game]
    if game != nil
      game_id = Game.find_by_name(game)
    else
      game_id = Game.find(params[:game_id])
    end
    level   = params[:level]
    @game = game_id
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
    @game = game_id
    @scores = Hash.new
    s = Highscore.find(:all, :select=>"level", :conditions=>["game_id=?", game_id], :order=>"score")
    levels = s.map{|l| l.level}.uniq
    levels.each { |l| @scores[l] = Highscore.find(:all, :conditions=>["game_id=? and level=?", game_id, l], :order=>"score", :limit=>3)}
  end

  def delete_level_scores
    game    = params[:game]
    if game != nil
      game_id = Game.find_by_name(game).id
    else
      game_id = Game.find(params[:game_id]).id
    end
    level   = params[:level].to_i
    Highscore.delete_all(["game_id = ? and level = ?",game_id, level])
    render(:nothing=>true)
  end
end

