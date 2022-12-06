data = File.read("../../inputs/day6.txt").split("")

window = ["", "", "", ""]

data.each_with_index do |c, i|
    window.delete_at(0)
    window << c

    if window.all? { |l| l != "" && window.count(l) == 1 }
        puts i + 1
        break
    end
end
