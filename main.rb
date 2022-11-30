year = nil
until ["2020", "2021"].include?(year)
	print "Enter year: "
	year = gets.chomp
end


day = nil
until Dir["#{year}/solutions/*"].include?("#{year}/solutions/day#{day}")
	print "Enter day: "
	day = gets.chomp
end	

part = nil
until ["1", "2"].include?(part)
	print "Enter part: "
	part = gets.chomp
end

Dir.chdir "#{year}/solutions/day#{day}"
require_relative "#{year}/solutions/day#{day}/part#{part}.rb"