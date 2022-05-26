require 'rails_helper'

describe 'usuário edita informações de prazo de entrega' do
  it 'se autenticado' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: carrier)
    visit edit_delivery_time_path(first_delivery_time)
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela inicial' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: carrier)
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 200, working_days: 5, carrier: carrier)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    first(:link, 'Editar Prazo').click
    expect(current_path).to eq edit_delivery_time_path(first_delivery_time)
    expect(page).to have_field 'Distância mínima', with: 0
    expect(page).to have_field 'Distância máxima', with: 100
    expect(page).to have_field 'Dias úteis', with: 2
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: carrier)
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 200, working_days: 5, carrier: carrier)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    first(:link, 'Editar Prazo').click    
    fill_in 'Distância mínima', with: 201
    fill_in 'Distância máxima', with: 300
    fill_in 'Dias úteis', with: 7
    click_on 'Enviar'
    
    expect(current_path).to eq delivery_times_path
    expect(page).to have_content 'Prazo de Entrega alterado com sucesso'
    expect(page).to have_content 'Prazos de Entrega'
    expect(page).to have_content 'Distância: 201 - 300 km'
    expect(page).to have_content 'Prazo: 7 dias úteis'
    expect(page).to have_content 'Distância: 101 - 200 km'
    expect(page).to have_content 'Prazo: 5 dias'

  end

  it 'sem sucesso e vê erros' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: carrier)
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 200, working_days: 5, carrier: carrier)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    first(:link, 'Editar Prazo').click    
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Dias úteis', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content 'Prazo de Entrega não pode ser alterado'
    expect(page).to have_content 'Distância mínima não pode ficar em branco'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Dias úteis não pode ficar em branco'  
  end

  it 'e não consegue editar prazos de outras transportadoras' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    second_carrier = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
        email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
        adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
        country: 'Brasil', status: 0)
    andre = User.create!(name: 'André', email: 'andre@saomiguel.com.br', password: 'password')  
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: first_carrier)
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 200, working_days: 5, carrier: second_carrier)
    
    login_as(joao, scope: :user)
    visit edit_delivery_time_path(second_delivery_time)
    
    expect(current_path).to eq root_path
    expect(page).to have_content 'Prazo de Entrega inexistente'
    expect(page).not_to have_field 'Distância mínima', with: 101
    expect(page).not_to have_field 'Distância máxima', with: 200
    expect(page).not_to have_field 'Dias úteis', with: 5
    


  end
end