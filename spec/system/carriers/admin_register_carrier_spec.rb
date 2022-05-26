require 'rails_helper'

describe 'admin registra transportadora' do
  # todo: a partir da tela de usuario_transportadora
  it 'a partir da tela inicial' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Registrar transportadora'

    expect(current_path).to eq new_carrier_path
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Domínio de email'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'País'
    expect(page).to have_field 'Status'

  end

  it 'com sucesso' do 
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Registrar transportadora'

    fill_in 'Razão social', with: 'Jamef Transportes Eireli'
    fill_in 'Nome fantasia', with: 'Jamef'
    fill_in 'Domínio de email', with: 'www.jamef.com.br'
    fill_in 'CNPJ', with: '11117617002276'
    fill_in 'Endereço', with: 'Rodovia Marechal Rondon, Km 348'
    fill_in 'Cidade', with: 'Barueri'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'País', with: 'Brasil'
    select 'Ativa', from: 'Status'
    click_on 'Enviar'
    
    expect(current_path).to eq carriers_path
    expect(page).to have_content 'Transportadora cadastrada com sucesso'   
    expect(page).to have_content 'Nome fantasia: Jamef'
    expect(page).to have_content 'Email: www.jamef.com.br'   
    expect(page).to have_content 'Status: Ativa'
  end

  it 'com dados incompletos' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Registrar transportadora'

    fill_in 'Razão social', with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'Domínio de email', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'País', with: ''
    
    click_on 'Enviar'
    
    expect(page).to have_content 'Transportadora não foi cadastrada'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Domínio de email não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'País não pode ficar em branco'
    
  end

  it 'com CNPJ duplicado' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    visit root_path
    click_on 'Transportadoras'
    click_on 'Registrar transportadora'
    
    
    fill_in 'Razão social', with: 'Super Expresso ltda'
    fill_in 'Nome fantasia', with: 'Super Entregas'
    fill_in 'Domínio de email', with: 'www.superentregas.com.br'
    fill_in 'CNPJ', with: '20147617002276'
    fill_in 'Endereço', with: 'Avenida Super'
    fill_in 'Cidade', with: 'Campinas'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'País', with: 'Brasil'
    select 'Ativa', from: 'Status'
    click_on 'Enviar'

    expect(page).to have_content 'Transportadora não foi cadastrada'
    expect(page).to have_content 'CNPJ já está em uso'

  end

  it 'com CNPJ comprimento errado' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Registrar transportadora'

    fill_in 'Razão social', with: 'Super Expresso ltda'
    fill_in 'Nome fantasia', with: 'Super Entregas'
    fill_in 'Domínio de email', with: 'www.superentregas.com.br'
    fill_in 'CNPJ', with: '2014761700' # tamanho errado, certo: 14
    fill_in 'Endereço', with: 'Avenida Super'
    fill_in 'Cidade', with: 'Campinas'
    fill_in 'Estado', with: 'São Paulo'
    fill_in 'País', with: 'Brasil'
    select 'Ativa', from: 'Status'
    click_on 'Enviar'

    expect(page).to have_content 'Transportadora não foi cadastrada'
    expect(page).to have_content 'CNPJ não possui o tamanho esperado (14 caracteres)'

  end
end