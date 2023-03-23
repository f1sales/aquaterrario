# frozen_string_literal: true

require_relative 'aquaterrario/version'
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Aquaterrario
  class Error < StandardError; end

  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'website',
          name: 'Website'
        }
      ]
    end
  end

  class F1SalesCustom::Email::Parser
    def parse
      {
        source: source,
        customer: customer,
        message: lead_message
      }
    end

    def parsed_email
      @email.body.colons_to_hash(/(#{regular_expression}).*?\n/, false)
    end

    def regular_expression
      'Nome|Celular|Email|Mensagem'
    end

    def source
      {
        name: F1SalesCustom::Email::Source.all[0][:name]
      }
    end

    def customer
      {
        name: customer_name,
        phone: customer_phone,
        email: customer_email
      }
    end

    def customer_name
      parsed_email['nome']
    end

    def customer_phone
      parsed_email['celular']
    end

    def customer_email
      parsed_email['email']
    end

    def lead_message
      parsed_email['mensagem']
    end
  end
end
