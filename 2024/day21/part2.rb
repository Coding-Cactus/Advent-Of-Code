NUMERIC = { "A" => 2 + 3i, "0" => 1 + 3i, "1" => 0 + 2i, "2" => 1 + 2i, "3" => 2 + 2i, "4" => 0 + 1i, "5" => 1 + 1i, "6" => 2 + 1i, "7" => 0 + 0i, "8" => 1 + 0i, "9" => 2 + 0i }
DIRECTIONAL = { "A" => 2 + 0i, "^" => 1 + 0i, ">" => 2 + 1i, "v" => 1 + 1i, "<" => 0 + 1i }
A_DIR_COORD = DIRECTIONAL["A"]

LEVELS = 25

$cache = {}

# min presses to click `button` `clicks` times starting at `coord`, through `levels` levels of robots
def min_presses(button, clicks, coord, levels)
  cache_key = [button, clicks, coord, levels]

  return $cache[cache_key] if $cache.include?(cache_key)

  target_c = DIRECTIONAL[button]
  delta = target_c - coord
  dx, dy = delta.real, delta.imag

  return dx.abs + dy.abs + clicks if levels == 1

  min =
    if dx.zero? || dy.zero?
      button = if dx.zero?
                 dy > 0 ? "v" : "^"
               else
                 dx > 0 ? ">" : "<"
               end
      min_presses(button, delta.magnitude, A_DIR_COORD, levels - 1) + min_presses("A", clicks, DIRECTIONAL[button], levels - 1)
    else
      possible_buttons = []
      possible_buttons << [dx > 0 ? ">" : "<", dx.abs, dy > 0 ? "v" : "^", dy.abs] unless coord.imag == 0 && target_c.real == 0 # if we don't start on the top and end at the left, we avoid the hole
      possible_buttons << [dy > 0 ? "v" : "^", dy.abs,  dx > 0 ? ">" : "<", dx.abs] unless coord.real == 0 && target_c.imag == 0 # if we don't start at the left and end on the top, we avoid the hole

      possible_buttons.map do |button1, b1clicks, button2, b2clicks|
        min_presses(button1, b1clicks, A_DIR_COORD, levels - 1) +
          min_presses(button2, b2clicks, DIRECTIONAL[button1], levels - 1) +
          min_presses("A", clicks, DIRECTIONAL[button2], levels - 1)
      end.min
    end

  $cache[cache_key] = min
  min
end


def solve(lines)
  lines.reduce(0) do |sum, code|
    coord = NUMERIC["A"]

    code.each_char.reduce(0) do |s, c|
      target_c = NUMERIC[c]
      delta = target_c - coord
      dx, dy = delta.real, delta.imag

      min =
        if dx.zero? || dy.zero?
          button = if dx.zero?
                     dy > 0 ? "v" : "^"
                   else
                     dx > 0 ? ">" : "<"
                   end
          min_presses(button, delta.magnitude, A_DIR_COORD, LEVELS) + min_presses("A", 1, DIRECTIONAL[button], LEVELS)
        else
          possible_buttons = []

          # left/right, then up/down
          # if we don't start on the bottom and end at the left, we avoid the hole
          possible_buttons << [dx > 0 ? ">" : "<", dx.abs, dy > 0 ? "v" : "^", dy.abs]  unless coord.imag == 3 && target_c.real == 0

          # up/down, then left/right
          # if we don't start at the left and end on the bottom, we avoid the hole
          possible_buttons << [dy > 0 ? "v" : "^", dy.abs,  dx > 0 ? ">" : "<", dx.abs] unless coord.real == 0 && target_c.imag == 3

          possible_buttons.map do |button1, b1clicks, button2, b2clicks|
            min_presses(button1, b1clicks, A_DIR_COORD, LEVELS) +
              min_presses(button2, b2clicks, DIRECTIONAL[button1], LEVELS) +
              min_presses("A", 1, DIRECTIONAL[button2], LEVELS)
          end.min
        end

      coord = target_c
      s + min
    end * code[...-1].to_i + sum
  end
end
