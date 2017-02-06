require 'clearbit_csv'
require 'csv'

describe 'csv' do
  let(:array_of_hashes){ [{"supplier"=>"Accenture (UK) Limited"}] } 

  describe CSV do

    subject(:csv){ CSV.to_a('./spec/pre.csv')}

    it 'generates file data' do
      expect(csv).to eq(array_of_hashes)
    end
  end

  describe Array do
    subject(:array){ array_of_hashes }

    it 'converts to csv' do
      expect(array.to_csv).to eq(CSV.to_a('./spec/pre.csv'))
    end
  end

  describe ClearbitCSV do
    subject(:clearbit_csv){ ClearbitCSV.generate(source: './spec/pre.csv', target: './spec/result.csv')}
    it 'generates a new csv' do
      expect(clearbit_csv).to eq(CSV.to_a('./spec/post.csv'))
    end

  end
end
