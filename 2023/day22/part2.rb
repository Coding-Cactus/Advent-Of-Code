require "fc"
require "set"

include FastContainers

# Calculates whether block1 is sat on top of block2
def on_top?((x1, y1, z1), (x2, y2, z2))
  z1.begin == z2.end + 1 &&
    (x1.begin <= x2.end && x1.end >= x2.begin) &&
    (y1.begin <= y2.end && y1.end >= y2.begin)
end

def solve(lines)
  blocks = PriorityQueue.new(:min)

  lines.each do |line|
    block_start, block_end = line.split("~")
    x_s, y_s, z_s = block_start.split(",").map(&:to_i)
    x_e, y_e, z_e = block_end.split(",").map(&:to_i)

    blocks.push([x_s..x_e, y_s..y_e, z_s..z_e], z_s)
  end

  settled_block_ends   = Hash.new { |h, k| h[k] = [] } # z-end-value   => block[]
  settled_block_starts = Hash.new { |h, k| h[k] = [] } # z-start-value => block[]
  until blocks.empty?
    block = blocks.pop
    z = block[2].begin

    until z == 1 || (!settled_block_ends[z-1].empty? && settled_block_ends[z-1].any? { |b| on_top?(block, b) })
      block[2] = (block[2].begin - 1)..(block[2].end - 1)
      z = block[2].begin
    end

    settled_block_ends[block[2].end]     << block
    settled_block_starts[block[2].begin] << block
  end

  unsafe = settled_block_ends.map do |z, row|
    row.reject do |removed|
      !settled_block_starts.include?(z+1) || settled_block_starts[z+1].none? do |above|
        row.none? { |below| below != removed && on_top?(above, below) }
      end
    end
  end.flatten(1)

  unsafe.reduce(0) do |count, remove|
    removed = Set[remove]

    in_queue = Set[]
    to_check = PriorityQueue.new(:min)
    to_check.push(remove[2].end + 1, remove[2].end + 1)

    until to_check.empty?
      z = to_check.pop
      in_queue.delete(z)

      settled_block_starts[z].each do |above|
        will_fall = settled_block_ends[z - 1].none? do |below|
          !removed.include?(below) && on_top?(above, below)
        end

        if will_fall
          removed << above
          z_above_above = above[2].end + 1
          unless in_queue.include?(z_above_above)
            in_queue << z_above_above
            to_check.push(z_above_above, z_above_above)
          end
        end
      end
    end

    count + removed.length - 1
  end
end
