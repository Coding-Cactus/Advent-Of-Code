sum = 0
s_to_i = { "0" => 0, "1" => 1, "2" => 2, "-" => -1, "=" => -2 }
i_to_s = { 0 => "0", 1 => "1", 2 => "2", 3 => "=", 4 => "-", 5 => "0" }
File.foreach("input.txt") do |line|
    l = line.strip.chars
    sum += l.each_with_index.reduce(0) { |t, (c, i)| t + s_to_i[c] * 5 ** (l.length - i - 1) }
end

snafu = ""
carry = 0
until sum == 0 && carry == 0
    remainder = sum % 5 + carry
    carry = remainder > 2 ? 1 : 0

    snafu = i_to_s[remainder] + snafu

    sum /= 5
end

puts snafu
