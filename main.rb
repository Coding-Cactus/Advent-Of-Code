type = year = day = part = nil

until %w[1 2].include?(type)
    print "\e[0m1. Run specific program\n2. Run latest program\nEnter 1/2: \e[36;3m"
    type = gets.chomp
end

case type
when "1"
  until Dir["*/"].include?("#{year}/")
    print "\e[0mEnter year: \e[36;3m"
    year = gets.chomp
  end

  until Dir["#{year}/*"].include?("#{year}/day#{day}")
    print "\e[0mEnter day: \e[36;3m"
    day = "%02d" % gets.chomp
  end

  until %w[1 2].include?(part)
    print "\e[0mEnter part: \e[36;3m"
    part = gets.chomp
  end
when "2"
  year = Dir["*/"].reduce(0) { |max, c| [c.to_i, max].max }
  day  = "%02d" % Dir["#{year}/*"].reduce(0) { |max, c| [c.split("/")[1][-2..-1].to_i, max].max }
  part = File.exists?("#{year}/day#{day}/part2.rb") ? 2 : 1
end

Dir.chdir("#{year}/day#{day}")

print "\e[0;32;1m"

start = Time.now
require_relative "#{year}/day#{day}/part#{part}.rb"
puts "\e[0mApproximate Runtime: \e[33;1m#{((Time.now - start) * 1000).round(2)}\e[0;33mms\e[0m"
