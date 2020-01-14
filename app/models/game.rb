class Game < ApplicationRecord
	has_many :frames
	has_many :balls, through: :frames

	before_save :calculate_score
	after_touch :save

	def roll pins
		errors = check_pins_count pins
		if errors.empty?
			ball = Ball.new pins: pins
	    if frames.last&.incomplete?
	      frames.last.balls << ball
	      self.save && frames.last.save
	    elsif frames.to_a.count == 10
	      return ["Game is completed: Total score: #{self.total_score}"]
	    else
	      frames << Frame.new(balls: [ ball ])
	    end
	    ball.errors.to_a
	  else
	  	errors
	  end
	end

	def calculate_score
		score = nil
    frames.each do |frame|
      current =
      if frame.strike?
        next_n_balls_score(frame.balls.first, 2)&.+ 10
      elsif frame.spare?
        frame.balls.second.value = '/'
        next_n_balls_score(frame.balls.second, 1)&.+ 10
      elsif frame.balls.size == 2
        frame.balls_total
      end
      break unless current
      score = score ? score + current : current
      frame.score = score
    end
    self.total_score = score
	end

	private

	def next_n_balls_score(current_ball, n)
    index = balls.index(current_ball)
    return nil unless index && (index + n < balls.size)
    balls[index + 1, n].reduce(0) { |sum, ball| sum + ball.pins }
  end

  def check_pins_count(pins)
  	frame = self.frames.select{|frame| frame.incomplete?}.last
  	return "" if !frame || frame.last?
  	existing_pins = frame.balls.last.pins

  	if existing_pins + pins > 10
  		"More than 10 pins in a frame. Wrong input."
  	else
  		""
  	end
  end
end
