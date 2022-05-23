require 'rails_helper'

describe 'usuário vê detalhes de um veículo' do
  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
              fab_year: '2007', max_cap: 100 , carrier: carrier)

    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Camry XLE 3.5 24V Aut.'
    expect(current_path).to eq vehicle_path(vehicle)
    expect(page).to have_content 'Detalhes de Camry XLE 3.5 24V Aut.'
    expect(page).to have_content 'Marca: Toyota'
    expect(page).to have_content 'Placa: GOX-1793'
    expect(page).to have_content 'Ano de Fabricação: 2007'
    expect(page).to have_content 'Capacidade Máxima: 100 kg'    
  end

  it 'e volta pro painel de usuario' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
              fab_year: '2007', max_cap: 100 , carrier: carrier)

    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Camry XLE 3.5 24V Aut.'
    click_on 'Voltar'
    expect(current_path).to eq vehicles_path

  end

  it 'não consegue ver detalhes de veículo que não pertence a sua transportadora' do
    carrier2 = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
      email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
      adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
      country: 'Brasil', status: 0)
    vehicle2 = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
                              fab_year: '2007', max_cap: 100 , carrier: carrier2)

    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
                              fab_year: '2007', max_cap: 100 , carrier: carrier)
    login_as(user)
    visit vehicle_path(vehicle2)
    expect(current_path).not_to eq vehicle_path(vehicle2)
    expect(current_path).to eq vehicles_path
    expect(page).to have_content 'Erro: Página não existe'
  end

  
end