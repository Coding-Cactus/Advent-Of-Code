require "json"

def solve(lines)
  workflows = {}

  on_workflows = true
  lines.reduce(0) do |sum, line|
    if on_workflows
      if line == ""
        on_workflows = false
      else
        name, conditions = line[...-1].split("{")
        conditions = conditions.split(",").map { |c| c.split(":") }
        workflows[name] = conditions
      end

      sum
    else
      part = JSON.load(line.gsub("=", '":').gsub(",", ',"').gsub("{", '{"'))

      workflow = "in"
      until workflow == "A" || workflow == "R"
        workflows[workflow].each do |condition|
          if condition.length == 1
            workflow = condition[0]
            break
          end

          condition, result = condition
          gt = condition.include?(">")
          letter, number = condition.split(gt ? ">" : "<")
          number = number.to_i

          if (gt && part[letter] > number) || (!gt && part[letter] < number)
            workflow = result
            break
          end
        end
      end

      sum + (workflow == "A" ? part.reduce(0) { |s, (_, v)| s + v } : 0)
    end
  end
end
