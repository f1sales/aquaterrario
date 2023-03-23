require 'ostruct'
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_helpers'

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when is from website' do
    let(:email) do
      email = OpenStruct.new
      email.to = [{ token: 'teste', host: 'lojateste.f1sales.net', email: 'teste@lojateste.f1sales.net',
                    full: 'teste@lojateste.f1sales.net', name: nil }]
      email.subject = 'Aquaterrário Contato'
      email.body = "Nome\nRafaela\nEmail\noperacional@clarearpropaganda.com.br\nCelular\n11947254755\nMensagem\nMensagem de Teste"

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[0][:name])
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Rafaela')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('operacional@clarearpropaganda.com.br')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('11947254755')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Mensagem de Teste')
    end
  end
end
