# frozen_string_literal: true

class Rover
  ORIENTATIONS = ['N', 'E', 'S', 'W'].freeze

  def initialize(world_size:, initial_position:, instructions:)
    @world_size = world_size
    @current_x = initial_position[:x]
    @current_y = initial_position[:y]
    @current_orientation = initial_position[:orientation]
    @instructions = instructions
    @status = nil
    @current_position = [{ x: @current_x, y: @current_y, orientation: @current_orientation }]
  end

  def explore
    make_the_move
    return if @status == 'LOST'
    @instructions.each do |instruction|
      case instruction
      when 'R', 'L'
        calculate_rotation(instruction)
      when 'F'
        calculate_move
      else
        raise(NotImplementedError, "Unexpected instruction: #{instruction}")
      end
      make_the_move
    end
  end

  def result
    @current_position.last&.merge({status: @status})
  end

  private

  def calculate_rotation(rotation)
    case rotation
    when 'R'
      current_index = ORIENTATIONS.index(@current_orientation)
      @current_orientation = ORIENTATIONS.rotate(current_index + 1).first
    when 'L'
      current_index = ORIENTATIONS.index(@current_orientation)
      @current_orientation = ORIENTATIONS.rotate(current_index + ORIENTATIONS.size - 1).first
    end
  end

  def calculate_move
    case @current_orientation
    when 'N'
      @current_y = @current_y + 1
    when 'E'
      @current_x = @current_x + 1
    when 'S'
      @current_y = @current_y - 1
    when 'W'
      @current_x = @current_x - 1
    else
      raise(NotImplementedError, "Unexpected orientation: #{@current_orientation}")
    end
  end

  def still_within_boundary?
    @current_x >= 0 && @current_x <= @world_size[:m] && @current_y >= 0 && @current_y <= @world_size[:n]
  end

  def make_the_move
    if still_within_boundary?
      @current_position << { x: @current_x, y: @current_y, orientation: @current_orientation }
    else
      @status = "LOST"
    end
  end
end
