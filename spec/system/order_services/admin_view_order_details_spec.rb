require 'rails_helper'

describe 'admin vê detalhes de uma ordem de serviço' do
  it 'se autenticado' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    visit order_service_path(1)
    expect(current_path).to eq new_admin_session_path
  end

  it 'a partir do menu inicial' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
        fab_year: '2009', max_cap: 85 , carrier: first_carrier)
        
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO',product_code: 'SA32SUMG-0231',
                  volume: 0.005, weight: 5.5, carrier: first_carrier,
                  coordinates: '14:50 -16.67861, -49.25389', accepted_status: 1, order_status: 1, vehicle: first_vehicle)
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on "Pedido #{first_order.code}"
    expect(page).to have_content "Detalhes do Pedido #{first_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aceitação alterada'
    expect(page).to have_content 'Status do Pedido: Aprovado'
    expect(page).to have_content 'Endereço de Retirada: Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP'
    expect(page).to have_content 'Endereço de Destino: Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO'
    expect(page).to have_content 'Código de Produto: SA32SUMG-0231'
    expect(page).to have_content 'Volume do Pedido: 0.005 m³'
    expect(page).to have_content 'Peso do Pedido: 5.5 kg'
    expect(page).to have_content 'Transportadora: Jamef'
    
  end

  it 'e volta pra página de ordens de serviço' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

    
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
        fab_year: '2009', max_cap: 85 , carrier: first_carrier)
        
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO',product_code: 'SA32SUMG-0231',
                  volume: 0.005, weight: 5.5, carrier: first_carrier,
                  coordinates: '14:50 -16.67861, -49.25389', accepted_status: 1, order_status: 1, vehicle: first_vehicle)
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on "Pedido #{first_order.code}"
    click_on 'Voltar'
    expect(current_path).to eq order_services_path
  end
end