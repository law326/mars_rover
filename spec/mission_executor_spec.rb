# frozen_string_literal: true

require 'spec_helper'
require './mission_executor'

RSpec.describe MissionExecutor do
  describe '#execute' do
    it 'creates world' do
      current_path = File.expand_path(File.dirname(__FILE__))
      file_path = File.join(current_path, 'fixtures/rover_command.txt')
      mission = described_class.new(file_path)
      mission.execute
      expect(mission.instance_variable_get(:@world)).to eq({ m: 4, n: 8 })
    end

    it 'commands rover' do
      current_path = File.expand_path(File.dirname(__FILE__))
      file_path = File.join(current_path, 'fixtures/rover_command.txt')
      mission = described_class.new(file_path)
      expect_any_instance_of(Rover).to receive(:explore)
      mission.execute
    end
  end
end
