class Frame < ApplicationRecord

	MAX_PINS = 10.freeze

	has_many :balls
	belongs_to :game, touch: true

	before_save :set_score

	def complete?
    if last?
      max = strike? || spare? ? 3 : 2
      balls.to_a.count == max
    else
      strike? || balls.to_a.count == 2
    end
  end

  def incomplete?
    !complete?
  end

  def strike?
    balls.first&.pins == MAX_PINS
  end

  def spare?
    return false if balls.to_a.count < 2
    balls.first.pins + balls.second.pins == MAX_PINS
  end

  def balls_total
    balls.reduce(0) { |sum, ball| sum + ball.pins }
  end

  def last?
    game.frames.to_a.count == MAX_PINS
  end

  private

  def set_score
  	self.score = balls_total
  end

end
