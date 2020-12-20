# frozen_string_literal: true

require './rover'

class MissionExecutor
  ROVER_COMMAND_REGEX = /\((?<x>\d), (?<y>\d), (?<orientation>N|E|S|W)\) (?<instructions>\w+)/

  def initialize(command_file_path)
    commands_file = File.open(command_file_path)
    @commands = commands_file.readlines.map(&:chomp)
  end

  def execute
    create_world
    command_rovers
  end

  def result
    puts @results.map { |result| "(#{result[:x]}, #{result[:y]}, #{result[:orientation]}) #{result[:status]}" }.join("\n")
  end

  private

  def create_world
    world_size = @commands[0].split.map(&:to_i)
    @world = { m: world_size[0], n: world_size[1] }
  end

  def command_rovers
    rovers = @commands.drop(1)
    @results = rovers.map do |rover_data|
      data = rover_data.match(ROVER_COMMAND_REGEX)
      rover = Rover.new(
        world_size: @world,
        initial_position: {
          x: data[:x].to_i,
          y: data[:y].to_i,
          orientation: data[:orientation]
        },
        instructions: data[:instructions].chars
      )
      rover.explore
      rover.result
    end
  end
end
