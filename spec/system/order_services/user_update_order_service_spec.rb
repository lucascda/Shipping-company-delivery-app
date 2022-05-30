require 'rails_helper'

describe 'usuário de transportadora atualiza ordem de serviço' do
  it 'como aceita' do
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

    first_vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
              fab_year: '2007', max_cap: 100 , carrier: first_carrier)
    second_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
      fab_year: '2009', max_cap: 85 , carrier: first_carrier)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
      
    visit root_path
    click_on 'Ordens de Serviço'
    first(:button, 'Aceitar').click
    
    expect(page).to have_content "Aprovação de #{first_order.code}"
    expect(page).to have_content "Selecione um veículo e confirme para aprovar pedido."
    select 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut', from: 'Veículo'
    click_on 'Enviar'

    expect(page).to have_content 'Ordem de Serviço aceita'    
    expect(page).to have_content "Detalhes do Pedido #{first_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aceitação alterada'
    expect(page).to have_content 'Status do Pedido: Aprovado'
    expect(page).to have_content "Veículo: #{second_vehicle.model}"
    expect(page).not_to have_content 'Pendente de Aceite: Aguardando aceitação'
    expect(page).not_to have_content 'Status do Pedido: Aguardando aprovação'
    expect(page).to have_content 'Endereço de Retirada: Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP'
    expect(page).to have_content 'Endereço de Destino: Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO'
    expect(page).to have_content 'Código de Produto: SA32SUMG-0231'
    expect(page).to have_content 'Volume do Pedido: 0.005 m³'
    expect(page).to have_content 'Peso do Pedido: 5.5 kg'
    expect(page).to have_content 'Transportadora: Jamef'
  end
   

  it 'e recusa ordem de serviço' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier,
          coordinates: '14:50 -16.67861, -49.25389')
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
            dest_adress: 'Rua diferente ',
            volume: 0.003, weight: 4.3, carrier: first_carrier, coordinates: '17:38 -16.6865, -49.4537',
            product_code: 'XIA414-OMI-9484') 
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
      
    visit root_path
    click_on 'Ordens de Serviço'
    first(:button, 'Recusar').click
    
    expect(current_path).to eq users_index_order_services_path
    expect(page).to have_content 'Ordem de Serviço recusada'
    expect(page).not_to have_content "Pedido #{first_order.code}"
    expect(page).not_to have_content "Endereço de Retirada: #{first_order.source_adress}"
    expect(page).not_to have_content "Endereço de Destino: #{first_order.dest_adress}"
    expect(page).not_to have_content "Volume do Pedido: #{first_order.volume} m³"
    expect(page).not_to have_content "Peso do Pedido: #{first_order.weight} kg"
  end

  
  
  
end