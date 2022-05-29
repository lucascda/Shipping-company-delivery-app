require 'rails_helper'

describe 'usuário de transportadora vê detalhes de ordem de serviço' do
  it 'se autenticado' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier,
          coordinates: '14:50 -16.67861, -49.25389')
    visit users_show_order_service_path(first_order)
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela inicial' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier,
          coordinates: '14:50 -16.67861, -49.25389')
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
          volume: 0.003, weight: 4.3, carrier: first_carrier, coordinates: '17:38 -16.6865, -49.4537',
          product_code: 'XIA414-OMI-9484')
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
      
    visit root_path
    click_on 'Ordens de Serviço'
    click_on "Pedido #{first_order.code}"
    expect(page).to have_content "Detalhes do Pedido #{first_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aguardando aceitação'
    expect(page).to have_content 'Status do Pedido: Aguardando aprovação'
    expect(page).to have_content 'Endereço de Retirada: Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP'
    expect(page).to have_content 'Endereço de Destino: Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO'
    expect(page).to have_content 'Código de Produto: SA32SUMG-0231'
    expect(page).to have_content 'Volume do Pedido: 0.005 m³'
    expect(page).to have_content 'Peso do Pedido: 5.5 kg'
    expect(page).to have_content 'Transportadora: Jamef'
  end

  it 'e não vê detalhes de ordem de serviço de outras transportadoras' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    second_carrier = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
       email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
       adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
       country: 'Brasil', status: 0)
    
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',product_code: 'SA32SUMG-0231',
                  volume: 0.005, weight: 5.5, carrier: first_carrier,
                  coordinates: '14:50 -16.67861, -49.25389')
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
                  volume: 0.003, weight: 4.3, carrier: second_carrier, coordinates: '17:38 -16.6865, -49.4537',
                  product_code: 'SA32SUMG-0231')
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit users_show_order_service_path(second_order)
    expect(page).not_to have_content "Pedido #{second_order.code}"
    expect(page).not_to have_content "Pendente de Aceite: #{second_order.accepted_status}"
    expect(page).not_to have_content "Status do Pedido: #{second_order.order_status}"
    expect(current_path).to eq root_path
    expect(page).to have_content 'Ordem de Serviço não pôde ser encontrada'
    
  end

  it 'e volta pra tela de ordens de serviço' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier,
          coordinates: '14:50 -16.67861, -49.25389')
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
          volume: 0.003, weight: 4.3, carrier: first_carrier, coordinates: '17:38 -16.6865, -49.4537',
          product_code: 'XIA414-OMI-9484')
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
      
    visit root_path
    click_on 'Ordens de Serviço'
    click_on "Pedido #{first_order.code}"
    click_on 'Voltar'
    expect(current_path).to eq users_index_order_services_path

  end
end