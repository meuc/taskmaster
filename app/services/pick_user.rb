class PickUser
  class << self
    def call(hash, size)
      with_fewest = hash[size].to_a.sort.reject do |key, users|
        users.blank?
      end.first.last

      if with_fewest.count == 1
        with_fewest.first
      else
        pick_with_fewest(hash, with_fewest, other_size(size))
      end
    end

    private

    def pick_with_fewest(hash, users, size)
      hash[size].inject({}) do |acc, (key, values)|
        acc[key] = values.select { |value| users.include?(value) }
        acc
      end.inject({}) do |acc, (key, values)|
        values.each { |value| acc[value] = key }
        acc
      end.to_a.sort_by(&:last).first.first
    end

    def other_size(size)
      if size == "small"
        "big"
      else
        "small"
      end
    end
  end
end
