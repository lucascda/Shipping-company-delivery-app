require 'rails_helper'

RSpec.describe Carrier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'corporate_name deve estar presente' do
        carrier = Carrier.new(corporate_name: '', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid

      end

      it 'brand_name deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: '',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'email_domain deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: '', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'registration_number deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'adress deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: '', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'city deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: '', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'state deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: '',
          country: 'Brasil', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'country deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: '', status: 0)
        
        expect(carrier).not_to be_valid
      end

      it 'status deve estar presente' do
        carrier = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: '')
        
        expect(carrier).not_to be_valid
      end
      
    end

    context 'uniqueness' do
      it 'email domain deve ser único' do
        carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)

        carrier2 = Carrier.new(corporate_name: 'Jamef Transportes', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Campinas', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier2).not_to be_valid
      end
    end

    context 'length' do
      it 'registration_number deve possuir 14 caracteres' do
        # registration_number com tamanho < 14
        carrier1 = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '201476170022',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)

        # registration_number com tamanho > 14  
        carrier2 = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '201476170022768989',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        # registration_number com tamanho == 14
        carrier3 = Carrier.new(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br', registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        
        expect(carrier1).not_to be_valid
        expect(carrier2).not_to be_valid
        expect(carrier3).to be_valid
      end
    end
  end
  
end
