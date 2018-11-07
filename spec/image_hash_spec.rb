RSpec.describe ImageHash do
  describe '#binary_hash' do
    context 'test1.png' do
      subject { described_class.new(File.expand_path('files/test1.png', __dir__)) }

      specify do
        expect(subject.binary_hash).to eq('1111110011100000000000000001000000011000001101001011011010010010')
      end
    end

    context 'test2.jpg' do
      subject { described_class.new(File.expand_path('files/test2.jpg', __dir__)) }

      specify do
        expect(subject.binary_hash).to eq('1111110011100000000000000001000000011000001101001011011010010011')
      end
    end

    context 'test3.jpg' do
      subject { described_class.new(File.expand_path('files/test3.jpg', __dir__)) }

      specify do
        expect(subject.binary_hash).to eq('1111110011100000000000000000000000011000001111001011011010010010')
      end
    end

    context 'test4.jpg' do
      subject { described_class.new(File.expand_path('files/test4.jpg', __dir__)) }

      specify do
        expect(subject.binary_hash).to eq('0011111100000111000000000000100000011000001011000110110111001001')
      end
    end

    context 'test5.jpg' do
      subject { described_class.new(File.expand_path('files/test5.jpg', __dir__)) }

      specify do
        expect(subject.binary_hash).to eq('1111111110100101100001010000010000000110010001101111011011111111')
      end
    end
  end

  describe '#hash' do
    context 'test1.png' do
      subject { described_class.new(File.expand_path('files/test1.png', __dir__)) }

      specify do
        expect(subject.hash).to eq('fce000101834b692')
      end
    end

    context 'test2.jpg' do
      subject { described_class.new(File.expand_path('files/test2.jpg', __dir__)) }

      specify do
        expect(subject.hash).to eq('fce000101834b693')
      end
    end
  end

  describe '.hex_to_binary' do
    it 'converts a hex string into a binary string' do
      expect(described_class.hex_to_binary('00')).to eq('00000000')
      expect(described_class.hex_to_binary('01')).to eq('00000001')
      expect(described_class.hex_to_binary('10')).to eq('00010000')
      expect(described_class.hex_to_binary('ff')).to eq('11111111')
      expect(described_class.hex_to_binary('FF')).to eq('11111111')
    end
  end

  describe '.binary_to_hex' do
    it 'converts a binary string into a hex string' do
      expect(described_class.binary_to_hex('00000000')).to eq('00')
      expect(described_class.binary_to_hex('00000001')).to eq('01')
      expect(described_class.binary_to_hex('00010000')).to eq('10')
      expect(described_class.binary_to_hex('11111111')).to eq('ff')
    end
  end

  describe '.binary_distance' do
    it 'returns the distance between two binary hashes' do
      expect(described_class.binary_distance('110100', '110100')).to eq(0)
      expect(described_class.binary_distance('110100', '110101')).to eq(1)
      expect(described_class.binary_distance('111111', '000000')).to eq(6)
    end
  end

  describe '.distance' do
    it 'returns the distance between two hex hashes' do
      expect(described_class.distance('d2', 'd2')).to eq(0)
      expect(described_class.distance('d2', 'd3')).to eq(1)
      expect(described_class.distance('d2', '52')).to eq(1)
      expect(described_class.distance('d2', '42')).to eq(2)
      expect(described_class.distance('ff', '00')).to eq(8)
    end
  end
end
