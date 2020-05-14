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

end

array_example = [1, 2, 3, "apple", "banana", "orange"]
hash_example = {1 => "apple", 2 => "banana", 3 => "orange"}

array_example.each do |n|
    puts n
end

array_example.my_each do |n|
    puts n
end

hash_example.each do |n, v|
    puts "#{n} and #{v}"
end

hash_example.my_each do |n, v|
    puts "#{n} and #{v}"
end


