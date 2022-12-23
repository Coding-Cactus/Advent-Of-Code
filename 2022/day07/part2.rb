class File
    attr_reader :size, :name

    def initialize(name, size)
        @name = name
        @size = size
    end
end

class Folder
    attr_accessor :name, :contents

    def initialize(name)
        @name = name
        @contents = []
    end

    def includes_item?(name)
        @contents.any? { |f| f.name == name }
    end

    def size
        @contents.reduce(0) { |s, f| s + f.size }
    end
end


folders = {}
cwdir = ""
reading_folder = nil

File.foreach("input.txt") do |line|
    line.strip!

    if line[0] == "$"
        case line.split[1]
        when "cd"
            name = line.split[2]
            if name == "/"
                cwdir = "/"
            elsif name == ".." && cwdir != "/"
                cwdir = cwdir.split("/")[0...-1].join("/")
            else
                slash = cwdir == "/" ? "" : "/"
                cwdir += slash + name
            end

            unless folders.has_key?(cwdir)
                folders[cwdir] = Folder.new(name)
            end
        when "ls"
            reading_folder = folders[cwdir]
        end
    else
        p1, p2 = line.split
        if p1 == "dir"
            unless reading_folder.includes_item?(p2)
                folder = Folder.new(p2)

                slash = cwdir == "/" ? "" : "/"
                folders[cwdir + "#{slash}#{p2}"] = folder
                reading_folder.contents << folder
            end
        else
            unless reading_folder.includes_item?(p2)
                reading_folder.contents << File.new(p2, p1.to_i)
            end
        end
    end
end

MAX = 70000000
NEED_FREE = 30000000

required = NEED_FREE - (MAX - folders["/"].size)

min_req = 999999999999999999999999

folders.each do |_, f|
    size = f.size
    if size > required && size < min_req
        min_req = size
    end
end

puts min_req
