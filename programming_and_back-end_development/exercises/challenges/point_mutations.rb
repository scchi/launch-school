class DNA
  def initialize(dna)
    @dna = dna
  end

  def hamming_distance(dna2)
    @dna[0, dna2.size].chars.map.with_index.count { |g, i| g != dna2[i] }
  end
end
