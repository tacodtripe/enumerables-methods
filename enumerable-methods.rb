module Enumerable

    def my_each
        return to_enum(:my_each) unless block_given?
        i=0
        while i < size
            if is_a? Hash
                yield(keys[i], self[keys[i]])
            elsif is_a? Array
                yield(self[i])
            end
        i += 1
        end
    end

    def my_each_with_index
        return to_enum(:my_each_with_index) unless block_given?
        i=0
        while i < size
            if is_a? Hash
                yield(keys[i], self[keys[i]])
            elsif is_a? Array
                yield(self[i], i)
            end
        i += 1
        end
    end


    def my_select
        return to_enum(:my_select) unless block_given?
        if is_a? Array
            empty_array = []
            my_each { |n| empty_array << n if yield(n) }
            empty_array
        elsif is_a? Hash
            empty_hash = {}
            my_each { |k, v| empty_hash[k] = v if yield(k, v)}
            empty_hash
        end
    end

    def my_all?
        return_values = []
        my_each do|n|
            return_values << yield(n)
        end
        if return_values.include?(false)
            false
        elsif
            true
        end
    end

end

array_example = [1, 2, 3, "apple", "banana", "orange"]
hash_example = {1 => "apple", 2 => "banana", 3 => "orange"}

puts "Ruby standard each method"

array_example.each do |n|
    puts n
end

hash_example.each do |n, v|
    puts "#{n} for #{v}"
end

puts "\nmy_each method"

array_example.my_each do |n|
    puts n
end

hash_example.my_each do |n, v|
    puts "#{n} for #{v}"
end

puts "\nRuby standard each_with_index method"

array_example.each_with_index do |n, i|
    puts "at index #{i} is #{n}"
end

puts "\nmy_each_with_index method"

array_example.my_each_with_index do |n, i|
    puts "at index #{i} is #{n}"
end

puts "\nRuby standard selec method"

puts array_example.select { |n| n.is_a? Numeric}

puts hash_example.select { |k, v| k > 1}

puts "\nmy_select method"

puts array_example.my_select { |n| n.is_a? Numeric}

puts hash_example.my_select { |k, v| k > 1}

puts "\nRuby standard all? method"

puts array_example.all? {is_a? Numeric}

puts "\nmy_all? method"

puts array_example.my_all? {is_a? Numeric}