module ActiveRecord
  class Base
    def self.random num=1
      set = num.times.collect do
        offset(rand(all.size)).first
      end
      num == 1 ? set[0] : set
    end
  end
end

