require 'rails_helper'

describe 'admin edita informações de transportadora' do
  # todo: a partir tela de admin
  it 'a partir de tela inicial' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Jamef'
    click_on 'Editar informações'
    expect(current_path).to eq edit_carrier_path(carrier.id)
  end

  it 'e vê informações da transportadora nos formulários' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Jamef'
    click_on 'Editar informações'

    expect(page).to have_field 'Razão social', with: 'Jamef Transportes Eireli'
    expect(page).to have_field 'Nome fantasia', with: 'Jamef'
    expect(page).to have_field 'Domínio de email', with: 'www.jamef.com.br'
    expect(page).to have_field 'CNPJ', with: '20147617002276'
    expect(page).to have_field 'Endereço', with: 'Rodovia Marechal Rondon, Km 348'
    expect(page).to have_field 'Cidade', with: 'Barueri'
    expect(page).to have_field 'Estado', with: 'São Paulo'
    expect(page).to have_field 'País', with: 'Brasil'
    expect(page).to have_field 'Status', with: 'active'
    
  end

  it 'e edita informações com sucesso' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Jamef'
    click_on 'Editar informações'

    select 'Inativa', from: 'Status'
    fill_in 'Razão social', with: 'Jamef Transportes'
    fill_in 'Endereço', with: 'Rodovia Marechal Rondon, Km 348, 250'
    click_on 'Enviar'
    expect(page).to have_content 'Transportadora atualizada com sucesso.'
    expect(page).to have_content 'Jamef Transportes'
    expect(page).to have_content 'Nome fantasia: Jamef'
    expect(page).to have_content 'Domínio de email: www.jamef.com.br'
    expect(page).to have_content 'CNPJ: 20147617002276'
    expect(page).to have_content 'Rodovia Marechal Rondon, Km 348, 250'
    expect(page).to have_content 'Cidade: Barueri'
    expect(page).to have_content 'Estado: São Paulo'
    expect(page).to have_content 'País: Brasil'
    expect(page).to have_content 'Status: Inativa'

  end

  it 'e mantém informações obrigatórias' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Jamef'
    click_on 'Editar informações'
    select 'Inativa', from: 'Status'
    fill_in 'Razão social', with: ''
    fill_in 'Nome fantasia', with: ''
    click_on 'Enviar'
    expect(page).to have_content 'Transportadora não foi atualizada'
    
  end

  
end