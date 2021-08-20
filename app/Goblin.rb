# frozen_string_literal: true

require 'ruby2d'
require 'Character'

# Goblin class
class Goblin < Character
  include Ruby2D

  def initialize(pos, face)
    super(10, sprite(pos), face)
  end

  def sprite(pos)
    @sprite ||= Sprite.new(
      'app/assets/goblinSpritesheet.png',
      x: pos[:x], y: pos[:y],
      width: 100, height: 100, clip_width: 40, time: 120,
      animations: { attacking: 1..7, idle: 12..15, death: 8..11, running: 17..24, injured: 25..28 }
    )

    # @boundingBox = Rectangle.new(
    #   x: @sprite.x, y: @sprite.y,
    #   width: @sprite.width, height: @sprite.height,
    #   color: 'teal',
    #   z: 20
    # )
  end
end
