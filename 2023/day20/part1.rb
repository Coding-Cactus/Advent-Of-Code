class Module
  def initialize(name, inputs, outputs)
    @name    = name
    @state   = false
    @inputs  = inputs
    @outputs = outputs
  end

  def add_input(new_inp)
    @inputs << new_inp unless @inputs.include?(new_inp)
  end

  def input(pulse, from)
    handle_input(pulse, from)
    output
  end

  private
    def handle_input(pulse, from) = nil
    def output = @outputs.map { |o| [o, @state, @name] }
end

class FlipFlop < Module
  @received = false

  private
    def handle_input(pulse, _)
      @state    = pulse ? @state : !@state
      @received = pulse
    end

    def output = (@received ? [] : @outputs).map { |o| [o, @state, @name] }
end

class Conjunction < Module
  def initialize(name, inputs, outputs)
    super(name, inputs, outputs)
    @memory = @inputs.map{ |i| [i, false] }.to_h
  end

  def add_input(new_inp)
    super(new_inp)
    @memory[new_inp] = false
  end

  private
    def handle_input(pulse, from)
      @memory[from] = pulse
      @state = !@memory.all? { |_, s| s }
    end
end

class Broadcast < Module
  private
    def handle_input(pulse, _) = @state = pulse
end

def solve(lines)
  modules = {}
  inputs = Hash.new { |h, k| h[k] = [] }

  lines.each do |line|
    name, outputs = line.split(" -> ")
    prefix, name = name[0], name[1..]
    outputs = outputs.split(", ")

    name = prefix + name unless prefix == "%" || prefix == "&"

    mod = case prefix
                when "%" then FlipFlop.new(name, inputs[name].clone, outputs)
                when "&" then Conjunction.new(name, inputs[name].clone, outputs)
                when "b" then Broadcast.new(name, inputs[name].clone, outputs)
                end

    modules[name] = mod

    outputs.each do |o|
      inputs[o] << name
      modules[o].add_input(name) if modules.include?(o)
    end
  end

  high = low = 0
  1000.times do
    signals = [["broadcaster", false, "button"]]
    until signals.empty?
      mod, pulse, from = signals.pop

      high += 1 if pulse
      low  += 1 if !pulse

      next if modules[mod].nil? # component doesn't connect to anything else

      modules[mod].input(pulse, from).each { |s| signals.unshift(s) }
    end
  end

  high * low
end
