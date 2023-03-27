require 'ostruct'
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_helpers'

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when is from website' do
    let(:email) do
      email = OpenStruct.new
      email.to = [{ token: 'website', host: 'aquaterrario.f1sales.net', email: 'website@aquaterrario.f1sales.net',
                    full: '"contato@garage8.com.br" <website@aquaterrario.f1sales.net>', name: '"contato@garage8.com.br"' }]
      email.subject = 'Aquaterrário Contato'
      email.body = 'Nome msimoesnt Email msimoesnttt@gmail.com (mailto:msimoesnttt@gmail.com) Celular 12991785364 Mensagem teste'

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[0][:name])
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('msimoesnt')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('msimoesnttt@gmail.com')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('12991785364')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('teste')
    end

    it 'contains product name' do
      expect(parsed_email[:product][:name]).to eq('')
    end
  end
end
