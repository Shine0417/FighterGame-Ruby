# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'ruby2d'
require 'Constants'
require 'CollisionHandler'

require 'Goblin'

set background: 'white', width: Constants::WIDTH, height: Constants::HEIGHT

@player = Goblin.new({ x: 0, y: 100 }, :RIGHT)
@player2 = Goblin.new({ x: 300, y: 100 }, :LEFT)

@sprites = []

@sprites.push(@player)
@sprites.push(@player2)

on :key_down do |event|
  case event.key
  when 'w'
    @player.move(:UP)
  when 'a'
    @player.move(:LEFT)
  when 's'
    @player.move(:DOWN)
  when 'd'
    @player.move(:RIGHT)
  when 'k'
    @player.attack
  when 'up'
    @player2.move(:UP)
  when 'left'
    @player2.move(:LEFT)
  when 'down'
    @player2.move(:DOWN)
  when 'right'
    @player2.move(:RIGHT)
  when 'k'
    @player2.attack
  end
end
on :key_up do |event|
  case event.key
  when 'w'
    @player.stop(:UP)
  when 'a'
    @player.stop(:LEFT)
  when 's'
    @player.stop(:DOWN)
  when 'd'
    @player.stop(:RIGHT)
  when 'up'
    @player2.stop(:UP)
  when 'left'
    @player2.stop(:LEFT)
  when 'down'
    @player2.stop(:DOWN)
  when 'right'
    @player2.stop(:RIGHT)
  when 'k'
    @player2.attack
  end
end

collision_handler = CollisionHandler.new

update do
  # if @player.idle?
  #   puts 'idle'
  # elsif @player.running?
  #   puts 'running'
  # elsif @player.attacking?
  #   puts 'attacking'
  # end
  @sprites.each do |now_sprite|
    original_location = { x: now_sprite.x, y: now_sprite.y }

    now_sprite.update

    @sprites.each do |sprite|
      if sprite != now_sprite && collision_handler.intersect(sprite, now_sprite)
        collision_handler.handle(original_location, now_sprite, sprite)
      end
    end
  end
end

show
