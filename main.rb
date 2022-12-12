year = nil
until ("2020".."2022").to_a.include?(year)
	print "\e[0mEnter year: \e[36;3m"
	year = gets.chomp
end

day = nil
until Dir["#{year}/solutions/*"].include?("#{year}/solutions/day#{day}")
	print "\e[0mEnter day: \e[36;3m"
	day = gets.chomp
end

part = nil
until %w[1 2].include?(part)
	print "\e[0mEnter part: \e[36;3m"
	part = gets.chomp
end

Dir.chdir("#{year}/solutions/day#{day}")

print "\e[0;32;1m"

start = Time.now
require_relative "#{year}/solutions/day#{day}/part#{part}.rb"
puts "\e[0mApproximate Runtime: \e[33;1m#{((Time.now - start) * 1000).round(2)}\e[0;33mms\e[0m"
