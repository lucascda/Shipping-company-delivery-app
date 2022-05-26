require 'rails_helper'

describe 'admin consegue ver detalhes de uma transportadora' do
  # todo: a partir da tela de admin
  it 'a partir da tela inicial' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Jamef'
    expect(page).to have_content 'Jamef Transportes Eireli'
    expect(page).to have_content 'Nome fantasia: Jamef'
    expect(page).to have_content 'Domínio de email: www.jamef.com.br'
    expect(page).to have_content 'CNPJ: 20147617002276'
    expect(page).to have_content 'Endereço: Rodovia Marechal Rondon, Km 348'
    expect(page).to have_content 'Cidade: Barueri'
    expect(page).to have_content 'Estado: São Paulo'
    expect(page).to have_content 'País: Brasil'
    expect(page).to have_content 'Status: Ativa'
  end

  it 'e volta pra tela de transportadoras' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Jamef'
    click_on 'Voltar'
    expect(current_path).to eq carriers_path
  end

  
end