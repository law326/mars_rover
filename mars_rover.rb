# frozen_string_literal: true

require './mission_executor'

mission = MissionExecutor.new('rover_commands/mars_rover_commands.txt')
mission.execute
mission.result
