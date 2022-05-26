require 'rails_helper'

describe 'usuário registra novo prazo de entrega' do
  it 'se estiver autenticado' do
    visit new_delivery_time_path
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela inicial' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar Prazos de Entrega'
    expect(current_path).to eq new_delivery_time_path
    expect(page).to have_content 'Cadastrar novo Prazo de Entrega'
    expect(page).to have_field 'Distância mínima'
    expect(page).to have_field 'Distância máxima'
    expect(page).to have_field 'Dias úteis'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar Prazos de Entrega'
    
    fill_in 'Distância mínima', with: '0'
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: '5'
    click_on 'Enviar'

    expect(current_path).to eq delivery_times_path
    expect(page).to have_content 'Prazo de Entrega criado com sucesso.'
    expect(page).to have_content 'Distância: 0 - 100 km'
    expect(page).to have_content 'Prazo: 5 dias úteis'
    
  end

  it 'sem sucesso e vê erros' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar Prazos de Entrega'
    
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: '100'
    fill_in 'Dias úteis', with: ''
    click_on 'Enviar'

    
    expect(page).to have_content 'Prazo de Entrega não pode ser criado'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Dias úteis não pode ficar em branco'

  end

  it 'e volta pra tela inicial ' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar Prazos de Entrega'
    click_on 'Voltar'
    expect(current_path).to eq delivery_times_path

  end
end