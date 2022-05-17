require 'rails_helper'

describe 'usuário visualiza transportadoras cadastradas' do
  # TODO: a partir da tela de admin
  it 'a partir da tela inicial' do
    visit(root_path)
    click_on 'Transportadoras'
    expect(page).to have_content 'Transportadoras cadastradas:'
    expect(current_path).to eq carriers_path    
  end

  it 'e visualiza transportadoras cadastradas' do
    carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
       email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
       adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
       country: 'Brasil', status: 0)
    carrier2 = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
        email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
        adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
        country: 'Brasil', status: 0)
    
    visit(root_path)
    click_on 'Transportadoras'
    expect(page).to have_content 'Nome fantasia: Jamef'
    expect(page).to have_content 'Email: www.jamef.com.br'
    expect(page).to have_content 'Status: Ativa'
    expect(page).to have_content 'Nome fantasia: São Miguel'
    expect(page).to have_content 'Email: www.saomiguel.com.br'
    expect(page).to have_content 'Status: Ativa'
  end

  it 'e não existem transportadoras cadastradas' do
    visit root_path
    click_on 'Transportadoras'
    expect(page).to have_content 'Não existem transportadoras cadastradas'
  end

  
end