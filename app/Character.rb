# frozen_string_literal: true

require 'ruby2d'
require 'aasm'
require 'set'

class Character
  include Ruby2D
  include AASM

  DIRECTION = {
    RIGHT: { x: 1, y: 0 },
    LEFT: { x: -1, y: 0 },
    UP: { x: 0, y: -1 },
    DOWN: { x: 0, y: 1 }
  }.freeze

  aasm whiny_transitions: false do
    state :idle, initial: true, after_enter: -> { @sprite.play animation: :idle, loop: true, flip: face }
    state :running,             after_enter: -> { @sprite.play animation: :running, flip: face }
    state :attacking,           after_enter: -> { @sprite.play animation: :attacking, flip: face { done! } }

    event :run do
      transitions from: :idle,      to: :running
      transitions from: :running,   to: :running
    end

    event :stop do
      transitions from: :running,   to: :idle
      transitions from: :idle,      to: :idle
    end

    event :attack do
      transitions from: %i[idle running], to: :attacking
    end

    event :done do
      transitions from: %i[idle running attacking], to: :idle
    end
  end

  aasm whiny_transitions: false do
    state :running,             after_enter: -> { @sprite.play animation: :running, flip: face }

    event :run do
      transitions from: :idle,      to: :running
      transitions from: :running,   to: :running
    end
  end

  def initialize(speed, sprite, face)
    @speed = speed
    @sprite = sprite
    @face = face
    @directions = Set[]
  end

  def update
    @directions.each do |direction|
      @sprite.x += DIRECTION[direction][:x] * @speed
      @sprite.y += DIRECTION[direction][:y] * @speed
    end
  end

  def move(direction)
    @face = direction if %i[RIGHT LEFT].include?(direction)
    run!
    @directions.add(direction)
  end

  def attack
    attack!
  end

  def stop(direction)
    @directions.delete(direction)
    stop! if @directions.empty?
  end

  def face
    :horizontal if @face == :LEFT
  end

  def x=(val)
    @sprite.x = val
  end

  def y=(val)
    @sprite.y = val
  end

  def x
    @sprite.x
  end

  def y
    @sprite.y
  end

  def height
    @sprite.height
  end

  def width
    @sprite.y
  end
end
