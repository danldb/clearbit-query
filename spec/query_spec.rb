require 'query'

describe Query do
  subject(:query){ Query.new(search_term, :clearbit)}
  let(:search_term){ 'Accenture (UK) Limited' }
  let(:response_data) do
    [
      {"domain" => "accenture.com","logo" => "https://logo.clearbit.com/accenture.com","name" => "Accenture"},
    ]
  end

  it 'gets data from clearbit' do
    expect(query.response.first).to eq(response_data.first)
  end
end
