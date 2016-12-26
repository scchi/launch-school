class PerfectNumber
  def self.classify(num)
    num < 0 ? (raise RuntimeError) : sum = sum_of_factors(num)

    case
      when sum > num then 'abundant'
      when sum < num then 'deficient'
      else 'perfect'
    end
  end

  private

  def self.sum_of_factors(num)
     (1..num/2).select { |div| num % div == 0 }.inject(&:+)
  end
end
