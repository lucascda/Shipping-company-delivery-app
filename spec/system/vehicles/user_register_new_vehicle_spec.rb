require 'rails_helper'

describe 'usuário cadastra novo veículo' do
  it 'se estiver autenticado' do
    visit root_path 
    expect(page).not_to have_link 'Veículos'
  end

  it 'a partir do painel de controle' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on 'Cadastrar Veículos'
    expect(page).to have_content 'Cadastro de Novo Veículo'
    expect(page).to have_field 'Placa'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Modelo'
    expect(page).to have_field 'Ano de Fabricação'
    expect(page).to have_field 'Capacidade Máxima'    

  end

  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')

    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on 'Cadastrar Veículos'

    fill_in 'Placa', with: 'GOX-1793'
    fill_in 'Marca', with: 'Toyota'
    fill_in 'Modelo', with: 'Camry XLE 3.5 24V Aut.'
    fill_in 'Ano de Fabricação', with: '2007'
    fill_in 'Capacidade Máxima', with: '100'
    click_on 'Enviar'
    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_content 'Camry XLE 3.5 24V Aut.'
    expect(page).to have_content '100 kg'
  end

  it 'com dados incompletos' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)   

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')

    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on 'Cadastrar Veículos'

    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Ano de Fabricação', with: ''
    fill_in 'Capacidade Máxima', with: ''
    click_on 'Enviar'
    expect(page).to have_content 'Veículo não pode ser cadastrado.'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Ano de Fabricação não pode ficar em branco'
    expect(page).to have_content 'Capacidade Máxima não pode ficar em branco'
  end

  it 'e volta pra página de veículos' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)   

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')

    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on 'Cadastrar Veículos'
    click_on 'Voltar para veículos'
    expect(current_path).to eq vehicles_path
    
  end

end