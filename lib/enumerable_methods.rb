# rubocop:disable Metrics/ModuleLength
module Enumerable
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_each
    return to_enum(:my_each) unless block_given?

    converted_array = to_a
    i = 0
    while i < converted_array.size
      yield(converted_array[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    converted_array = to_a
    i = 0
    while i < converted_array.size
      yield(converted_array[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if is_a? Array
      empty_array = []
      my_each { |n| empty_array << n if yield(n) }
      empty_array
    elsif is_a? Hash
      empty_hash = {}
      my_each { |k, v| empty_hash[k] = v if yield(k, v) }
      empty_hash
    elsif is_a? Range
      empty_array = []
      my_each { |n| empty_array << n if yield(n) }
      empty_array
    end
  end

  def my_all?(param = nil)
    result = true
    my_each do |value|
      if block_given?
        result = false unless yield(value)
      elsif param.nil?
        result = false unless value
      else
        result = false unless param === value # rubocop:disable Style/CaseEquality
      end
    end
    result
  end

  def my_any?(args = nil)
    result = false
    if args.nil? && !block_given?
      my_each { |x| result = true unless x.nil? || !x }
    elsif args.nil?
      my_each { |x| result = true if yield(x) }
    elsif args.is_a? Regexp
      my_each { |x| result = true if x.match(args) }
    elsif args.is_a? Module
      my_each { |x| result = true if x.is_a?(args) }
    else
      my_each { |x| result = true if x == args }
    end
    result
  end

  def my_none?(args = nil)
    result = true
    if args.nil? && !block_given?
      my_each { |x| result = false if x == true }
    elsif args.nil?
      my_each { |x| result = false if yield(x) }
    elsif args.is_a? Regexp
      my_each { |x| result = false if x.match(args) }
    elsif args.is_a? Module
      my_each { |x| result = false if x.is_a?(args) }
    else
      my_each { |x| result = false if x == args }
    end
    result
  end

  def my_count(args = nil)
    total = 0
    if args
      my_each { |i| total += 1 if i == args }
    elsif !block_given?
      total = size
    elsif !args
      my_each { |i| total += 1 if yield i }
    end
    total
  end

  def my_map(proc = nil)
    result = []
    if block_given?
      my_each { |item| result.push(yield(item)) } unless proc
      my_each { |item| result << proc.call(item) } if proc
    elsif proc
      my_each { |item| result << proc.call(item) }
    else
      return to_enum
    end
    result
  end

  def my_inject(*args)
    array = is_a?(Range) ? to_a : self

    argument = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]

    if operator
      array.my_each { |i| argument = argument ? argument.send(operator, i) : i }
      return argument
    end
    array.my_each { |i| argument = argument ? yield(argument, i) : i }
    argument
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
# rubocop:enable Metrics/ModuleLength
def multiply_els(array)
  array.my_inject { |memo, n| memo * n }
end
