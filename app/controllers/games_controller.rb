class GamesController < ApplicationController
	before_action :set_game, except: :create

  def create
  	@game = Game.create!
    render json: @game
  end

  def show
  	render json: @game, 
  	:only => [:total_score], include: {:frames => {:only => [:score], :include => {:balls => {:only => [:pins] }}}}
  end

  def roll
  	errors = @game&.roll params[:pins]
    if errors&.empty?
      render json: @game, :only => [:total_score], include: {:frames => {:only => [:score], :include => {:balls => {:only => [:pins] }}}}
    else
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  def game_status
  	render json: @game, :only => [:total_score], include: {:frames => {:only => [:score]}}
  end

  private

  def set_game
    @game = Game.find params[:id] || params[:game_id]
  end
end
