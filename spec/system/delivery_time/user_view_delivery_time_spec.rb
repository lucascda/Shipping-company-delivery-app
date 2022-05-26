require 'rails_helper'

describe 'usuário vê prazos de sua transportadora' do
  it 'se estiver autenticado' do
    visit delivery_times_path    
    expect(current_path).to eq new_user_session_path

  end

  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: carrier)
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 300, working_days: 5, carrier: carrier)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    
    expect(current_path).to eq delivery_times_path
    expect(page).to have_content 'Prazos de Entrega'
    expect(page).to have_content 'Distância: 0 - 100 km'
    expect(page).to have_content 'Prazo: 2 dias úteis'
    expect(page).to have_content 'Distância: 101 - 300 km'
    expect(page).to have_content 'Prazo: 5 dias'

  end

  it 'e não vê prazos de entrega cadastrados' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    expect(page).to have_content 'Não há Prazos de Entrega cadastrados.'

  end

  it 'e nâo vê prazos de entrega de outras transportadoras' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: first_carrier)
    
    second_carrier = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
      email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
      adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
      country: 'Brasil', status: 0)
    jose = User.create!(name: 'José', email: 'jose@saomiguel.com.br', password: 'password')
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 300, working_days: 5, carrier: second_carrier)
    
    login_as(joao, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'

    expect(page).to have_content 'Prazos de Entrega'
    expect(page).to have_content 'Distância: 0 - 100 km'
    expect(page).to have_content 'Prazo: 2 dias úteis'
    expect(page).not_to have_content 'Distância: 101 - 300 km'
    expect(page).not_to have_content 'Prazo: 5 dias'

  end

  it 'e volta pra tela inicial' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Voltar'
    expect(current_path).to eq root_path   
  end

end