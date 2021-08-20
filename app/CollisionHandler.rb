# frozen_string_literal: true

class CollisionHandler
  def handle(original_location, from, to)
    if (from.instance_of? Goblin) && (to.instance_of? Goblin)
      direction = { x: from.x - original_location[:x], y: from.y - original_location[:y] }
      from.x = original_location[:x]
      from.y = original_location[:y]
      to.x = to.x + direction[:x] / 3
      to.y = to.y + direction[:y] / 3
    end
  end

  def intersect(first, second)
    result = false
    puts "(#{first.x}, #{first.y}), (#{second.x}, #{second.y})"

    if first.x < second.x && first.y < second.y
      result = (first.x + first.width) > second.x && (first.y + first.height) > second.y
    elsif first.x >= second.x && first.y < second.y
      result = (second.x + second.width) > first.x && (first.y + first.height) > second.y
    elsif first.x < second.x && first.y >= second.y
      result = (first.x + first.width) > second.x && (second.y + second.height) > first.y
    elsif first.x >= second.x && first.y >= second.y
      result = (second.x + second.width) > first.x && (second.y + second.height) > first.y
    end

    # puts result
    result
  end
end
