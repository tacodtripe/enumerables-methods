require 'spec_helper.rb'
require 'enumerable_methods.rb'

describe Enumerable do
  describe '#my_each' do
    it 'if no block was given, return an enumerator' do
      expect([1, 2, 3].my_each.class).to eq(Enumerator)
    end

    it 'iterates over every single element of the array' do
      expect([1, 2, 3].my_each { |n| n }).to eq([1, 2, 3])
    end
  end

  describe '#my_each_with_index' do
    it 'if no block was given, return an enumerator' do
      expect([1, 2, 3].my_each_with_index.class).to eq(Enumerator)
    end

    it 'iterates over every single element of the array and asign an index' do
      hash = {}
      [1, 2, 3].my_each_with_index { |n, i| hash[i] = n }
      expect(hash).to eq(0 => 1, 1 => 2, 2 => 3)
    end
  end

  describe '#my_select' do
    it 'return and array with all the elements that returned true to the block given' do
      expect([1, 2, 3].my_select { |n| n > 1 }).to eq([2, 3])
    end
  end

  describe '#my_all?' do
    it 'return true if all the elements return true to the block given' do
      expect([2, 3].my_all? { |n| n > 1 }).to eq(true)
    end

    it 'return false if any element return false to the block given' do
      expect([1, 2, 3].my_all? { |n| n > 1 }).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'return true if any element return true to the block given' do
      expect([2, 3].my_any? { |n| n > 1 }).to eq(true)
    end

    it 'return false if no element return true to the block given' do
      expect([1, 2, 3].my_any? { |n| n > 4 }).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'return true if no element return true to the block given' do
      expect([1, 2, 3].my_none? { |n| n > 4 }).to eq(true)
    end

    it 'return false if any element return true to the block given' do
      expect([1, 2, 3, 5].my_none? { |n| n > 4 }).to eq(false)
    end
  end

  describe '#my_count' do
    it 'if no block given return the number of elements of the array' do
      expect([1, 2, 3, 5].my_count).to eq(4)
    end

    it 'If an argument is given, counts the number of elements which equal obj using ==' do
      expect([1, 2, 3, 5].my_count(2)).to eq(1)
    end

    it 'If a block is given, counts the number of elements for which the block returns a true value' do
      expect([1, 2, 3, 5].my_count { |n| n > 2 }).to eq(2)
    end
  end

  describe '#my_map' do
    it 'return a new array with the results of running block once for every element in enum' do
      expect([1, 2, 3].my_map { |n| n * 2 }).to eq([2, 4, 6])
    end
  end

  describe '#my_inject' do
    it 'if given a symbol that defines an operatoras a parameter it should aply to all elements' do
      expect([1, 2, 3, 4].my_inject(:+)).to eql(10)
    end

    it 'if block is given it should yield every element to the block and return the acumulated result' do
      expect([1, 2, 3, 4].my_inject { |acc, n| acc + n }).to eql(10)
    end
  end
end
