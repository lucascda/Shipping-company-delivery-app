require 'rails_helper'

describe 'usuário registra novo preço' do
  it 'se estiver autenticado' do
    visit new_shipping_price_path
    expect(current_path).to eq new_user_session_path

  end
  it 'a partir da tela inicial' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Preços'
    click_on 'Cadastrar novo preço'

    expect(current_path).to eq new_shipping_price_path
    expect(page).to have_field 'Volume mínimo'
    expect(page).to have_field 'Volume máximo'
    expect(page).to have_field 'Peso mínimo'
    expect(page).to have_field 'Peso máximo'
    expect(page).to have_field 'Preço por km'
    expect(page).to have_button 'Salvar'
    
  end

  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Preços'
    click_on 'Cadastrar novo preço'

    fill_in 'Volume mínimo', with: '0.001'
    fill_in 'Volume máximo', with: '0.005'
    fill_in 'Peso mínimo', with: '0.1'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Preço por km', with: '0.5'
    click_on 'Salvar'

    expect(page).to have_content 'Preço de Entrega cadastrado com sucesso.'
    expect(page).to have_content '0.001 - 0.005'
    expect(page).to have_content '0.1 a 10.0 kg'
    expect(page).to have_content 'R$ 0.5'


  end

  it 'com dados incompletos' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Preços'
    click_on 'Cadastrar novo preço'

    fill_in 'Volume mínimo', with: ''
    fill_in 'Volume máximo', with: ''
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Preço por km', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Preço de Entrega não pode ser cadastrado'
    expect(page).to have_content 'Volume mínimo não pode ficar em branco'
    expect(page).to have_content 'Volume máximo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Preço por km não pode ficar em branco'

  end

  
end