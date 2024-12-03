def solve(lines) = lines.join.split("do()").map { |sec| sec.split("don't()").first }.join
                        .scan(/mul\((\d{1,3}),(\d{1,3})\)/)
                        .map { |(x, y)| x.to_i * y.to_i }
                        .sum
