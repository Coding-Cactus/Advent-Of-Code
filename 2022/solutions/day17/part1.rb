class Shape
    attr_accessor :top_left
    attr_reader :width, :height, :points

    def initialize(points)
        @points = points
        @width, @height = points.reduce([0, 0]) { |(mw, mh), (x, y)| [[mw, x+1].max, [mh, y+1].max] }
        @top_left = [0, 0]
    end

    def v_stopping?(rock)
        @points.each do |lower_x, lower_y|
            lx, ly = @top_left[0] + lower_x, @top_left[1] - lower_y
            rock.points.each do |upper_x, upper_y|
                ux, uy = rock.top_left[0] + upper_x, rock.top_left[1] - upper_y
                return true if lx == ux && ly + 1 == uy
            end
        end

        false
    end

    def h_stopping?(rock, direction)
        @points.each do |_x1, _y1|
            x1, y1 = @top_left[0] + _x1, @top_left[1] - _y1
            rock.points.each do |_x2, _y2|
                x2, y2 = rock.top_left[0] + _x2, rock.top_left[1] - _y2
                return true if y1 == y2 && x2 + direction == x1
            end
        end

        false
    end
end

def stopped_in_range(stopped, y)
    ((y-5)..(y+5)).map { |n| stopped[n] }.flatten
end

shapes = [
    Shape.new([[0, 0], [1, 0], [2, 0], [3, 0]]),
    Shape.new([[1, 0], [2, 1], [1, 2], [0, 1]]),
    Shape.new([[2, 0], [2, 1], [2, 2], [1, 2], [0, 2]]),
    Shape.new([[0, 0], [0, 1], [0, 2], [0, 3]]),
    Shape.new([[0, 0], [1, 0], [1, 1], [0, 1]])
]

jets = File.read("../../inputs/day17.txt").strip.split("")

j = 0
stopped = Hash.new { |h, k| h[k] = [] }
highest = -1
WIDTH = 7

(0...2022).each do |i|
    rock = shapes[i % 5].clone
    x, y = 2, highest + 3 + rock.height

    moving = true
    while moving
        rock.top_left = [x, y]
        if jets[j] == ">"
            if x + rock.width < WIDTH && stopped_in_range(stopped, y).none? { |r| r.h_stopping?(rock, 1) }
                x += 1
            end
        elsif x > 0 && stopped_in_range(stopped, y).none? { |r| r.h_stopping?(rock, -1) }
            x -= 1
        end

        rock.top_left = [x, y]
        if y == rock.height - 1 || stopped_in_range(stopped, y).any? { |r| r.v_stopping?(rock) }
            highest = [highest, y].max
            rock.top_left = [x, y]
            stopped[y] << rock
            moving = false
        else
            y -= 1
        end

        j = (j + 1) % jets.length
    end
end

puts highest + 1
