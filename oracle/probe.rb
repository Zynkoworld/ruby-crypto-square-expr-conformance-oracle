class Crypto

  def initialize(plaintext)
    @plaintext = plaintext
  end

  def ciphertext
    transposed.join(' ')
  end

  private

  def normalize_plaintext
    @normalized ||= @plaintext.downcase.gsub(/\W/, '')
  end

  def plaintext_segments
    if size > 0
      normalize_plaintext.chars.
                          each_slice(size).
                          map{ |s| s.join('') }.
                          to_a
    else
      []
    end
  end

  def size
    Math.sqrt(normalize_plaintext.length).ceil
  end

  def transposed
    chunk_size = size
    chunks = plaintext_segments.map do |s|
        Array.new(chunk_size) { |i| s[i] or ' ' }
    end
    chunks.transpose.map{ |s| s.join('') }
  end

end

require 'json'
__exprs = JSON.parse("[\"Crypto.new('').ciphertext\", \"Crypto.new('... --- ...').ciphertext\", \"Crypto.new('A').ciphertext\", \"Crypto.new('  b ').ciphertext\", \"Crypto.new('@1,%!').ciphertext\", \"Crypto.new('This is fun!').ciphertext\", \"Crypto.new('Chill out.').ciphertext\", \"Crypto.new('If man was meant to stay on the ground, god would have given us roots.').ciphertext\"]")
__out = []
__exprs.each do |e|
  begin
    __out << {ok: true, v: eval(e)}
  rescue => ex
    __out << {ok: false, e: ex.class.to_s}
  end
end
puts JSON.generate({out: __out})
