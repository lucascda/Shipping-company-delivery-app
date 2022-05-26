require 'rails_helper'

describe 'usuário de transportadora edita informações' do
  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
                              fab_year: '2007', max_cap: 100 , carrier: carrier)
    
    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on vehicle.model
    click_on 'Editar informações'
    expect(current_path).to eq edit_vehicle_path(vehicle)
    fill_in 'Placa', with: 'HMW-3001'
    fill_in 'Modelo', with: 'PT Cruiser Limited 2.4 16V 143cv 4p'
    fill_in 'Marca', with: 'Chrysler'
    fill_in 'Ano de Fabricação', with: '2005'
    fill_in 'Capacidade Máxima', with: '98'
    click_on 'Enviar'

    expect(page).to have_content 'Edição de veículo confirmada'
    expect(page).to have_content 'Detalhes de PT Cruiser Limited 2.4 16V 143cv 4p'
    expect(page).to have_content 'Marca: Chrysler'
    expect(page).to have_content 'Placa: HMW-3001'
    expect(page).to have_content 'Ano de Fabricação: 2005'
    expect(page).to have_content 'Capacidade Máxima: 98 kg'
  end

  it 'com informações incompletas' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
                              fab_year: '2007', max_cap: 100 , carrier: carrier)
    
    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on vehicle.model
    click_on 'Editar informações'
    fill_in 'Placa', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Ano de Fabricação', with: ''
    fill_in 'Capacidade Máxima', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Edição de veículo não pôde ser concluída'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Ano de Fabricação não pode ficar em branco'
    expect(page).to have_content 'Capacidade Máxima não pode ficar em branco'
  end

  it 'e volta pra página de veículos' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
                              fab_year: '2007', max_cap: 100 , carrier: carrier)

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')

    login_as(user, scope: :user)
    visit root_path 
    click_on 'Veículos'
    click_on vehicle.model
    click_on 'Editar informações'
    click_on 'Voltar para detalhes de Veículo'
    expect(current_path).to eq vehicle_path(vehicle)
  end

  it 'não consegue editar informações de um veículo de outra transportadora' do
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
    
    login_as(user, scope: :user)
    visit edit_vehicle_path(vehicle2)
    
    expect(current_path).not_to eq edit_vehicle_path(vehicle2)
    expect(current_path).to eq vehicles_path
    expect(page).to have_content 'Erro: Página não existe'
    

  end
  
end