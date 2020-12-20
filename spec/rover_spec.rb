# frozen_string_literal: true

require 'spec_helper'
require './rover'

RSpec.describe Rover do
  describe '#explore' do
    context 'when encounter unexpected instruction' do
      it 'raises error' do
        world_size = { m: 6, n: 6 }
        position = { x: 1, y: 1, orientation: 'E' }
        rover = described_class
          .new(world_size: world_size, initial_position: position, instructions: ['U'])

        expect { rover.explore }
        .to raise_error(NotImplementedError, 'Unexpected instruction: U')
      end
    end

    context 'when given instruction R' do
      it 'rotates correctly for all orientations' do
        world_size = { m: 6, n: 6 }
        expected_orientation_map = {
          'N' => 'E',
          'E' => 'S',
          'S' => 'W',
          'W' => 'N'
        }
        expected_orientation_map.each do |current, expected|
          position = { x: 1, y: 1, orientation: current }
          rover = described_class
            .new(world_size: world_size, initial_position: position, instructions: ['R'])
          rover.explore
          expect(rover.result).to eq({ x: 1, y: 1, orientation: expected, status: nil })
        end
      end
    end

    context 'when given instruction L' do
      it 'rotates correctly for all orientations' do
        world_size = { m: 6, n: 6 }
        expected_orientation_map = {
          'N' => 'W',
          'E' => 'N',
          'S' => 'E',
          'W' => 'S'
        }
        expected_orientation_map.each do |current, expected|
          position = { x: 1, y: 1, orientation: current }
          rover = described_class
            .new(world_size: world_size, initial_position: position, instructions: ['L'])
          rover.explore
          expect(rover.result).to eq({ x: 1, y: 1, orientation: expected, status: nil })
        end
      end
    end
  end

  context 'when given instruction F' do
    context 'when orientation is N' do
      subject do
        world_size = { m: 6, n: 6 }
        position = { x: 1, y: 1, orientation: 'N' }
        rover = described_class
          .new(world_size: world_size, initial_position: position, instructions: ['F'])
        rover.explore
        rover.result
      end

      it { is_expected.to eq({ x: 1, y: 2, orientation: 'N', status: nil }) }
    end

    context 'when orientation is E' do
      subject do
        world_size = { m: 6, n: 6 }
        position = { x: 1, y: 1, orientation: 'E' }
        rover = described_class
          .new(world_size: world_size, initial_position: position, instructions: ['F'])
        rover.explore
        rover.result
      end

      it { is_expected.to eq({ x: 2, y: 1, orientation: 'E', status: nil }) }
    end

    context 'when orientation is S' do
      subject do
        world_size = { m: 6, n: 6 }
        position = { x: 1, y: 1, orientation: 'S' }
        rover = described_class
          .new(world_size: world_size, initial_position: position, instructions: ['F'])
        rover.explore
        rover.result
      end

      it { is_expected.to eq({ x: 1, y: 0, orientation: 'S', status: nil }) }
    end

    context 'when orientation is W' do
      subject do
        world_size = { m: 6, n: 6 }
        position = { x: 1, y: 1, orientation: 'W' }
        rover = described_class
          .new(world_size: world_size, initial_position: position, instructions: ['F'])
        rover.explore
        rover.result
      end

      it { is_expected.to eq({ x: 0, y: 1, orientation: 'W', status: nil }) }
    end
  end

  describe '#still_within_boundary?' do
    context 'when robot is still within the grid' do
      subject do
        world_size = { m: 6, n: 6 }
        position = { x: 4, y: 5, orientation: 'N' }
        described_class
          .new(world_size: world_size, initial_position: position, instructions: [])
          .send(:still_within_boundary?)
      end

      it { is_expected.to eq(true) }
    end

    context 'when robot is off the grid' do
      subject do
        world_size = { m: 3, n: 3 }
        position = { x: 4, y: 5, orientation: 'N' }
        described_class
          .new(world_size: world_size, initial_position: position, instructions: [])
          .send(:still_within_boundary?)
      end

      it { is_expected.to eq(false) }
    end
  end
end
