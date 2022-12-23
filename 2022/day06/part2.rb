data = File.read("input.txt").split("")

window = Array::new(14) { "" }

data.each_with_index do |c, i|
    window.delete_at(0)
    window << c

    if window.all? { |l| l != "" && window.count(l) == 1 }
        puts i + 1
        break
    end
end
