require 'rails_helper'

describe 'usuário atualiza rota com novas coordenadas' do
  it 'se estiver autenticado' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1)
    
    visit new_order_service_order_route_path(first_order)
    expect(current_path).to eq new_user_session_path

  end
  it 'com sucesso' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1)
    first_route = OrderRoute.create!(coordinates: "-16.6865, -49.4537", date: "28/05/2022", time: "04:59", order_service: first_order)
    

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens de Serviço Aceitas'
    click_on "Pedido #{first_order.code}"
    click_on 'Atualizações de rota'
    click_on 'Adicionar nova Atualização de Rota'
    
    expect(page).to have_content "Nova atualização de rota para Pedido #{first_order.code}"
    expect(page).to have_field 'Data'
    expect(page).to have_field 'Horário'
    expect(page).to have_field 'Coordenada Geográfica'
    expect(page).to have_button 'Enviar'
    fill_in 'Data', with: '28/05/2022'
    fill_in 'Horário', with: '10:45'
    fill_in 'Coordenada Geográfica', with: "-13.6865, -45.4537"
    click_on 'Enviar'

    expect(current_path).to eq order_service_order_routes_path(first_order)
    expect(page).to have_content 'Rota atualizada com sucesso'
    expect(page).to have_content "Atualizações de Rota de Pedido #{first_order.code}:"
    expect(page).to have_content "Coordenada Geográfica: #{first_route.coordinates}"
    expect(page).to have_content "Data e Hora: 28/05/2022 - 04:59"
    expect(page).to have_content "Coordenada Geográfica: -13.6865, -45.4537"
    expect(page).to have_content "Data e Hora: 28/05/2022 - 10:45"
    
  end

  it 'sem sucesso e vê erros' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1)
    first_route = OrderRoute.create!(coordinates: "-16.6865, -49.4537", date: "28/05/2022", time: "04:59", order_service: first_order)
    

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens de Serviço Aceitas'
    click_on "Pedido #{first_order.code}"
    click_on 'Atualizações de rota'
    click_on 'Adicionar nova Atualização de Rota'
    
    fill_in 'Data', with: ''
    fill_in 'Horário', with: ''
    fill_in 'Coordenada Geográfica', with: ""
    click_on 'Enviar'

    expect(page).to have_content 'Atualização de rota não pôde ser realizada'
    expect(page).to have_content 'Data não pode ficar em branco'
    expect(page).to have_content 'Coordenada Geográfica não pode ficar em branco'
    expect(page).to have_content 'Horário não pode ficar em branco'

  end

  it 'e não consegue criar atualizações em pedidos de outras transportadoras' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    second_carrier = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
        email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
        adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
        country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1)
    first_route = OrderRoute.create!(coordinates: "-16.6865, -49.4537", date: "28/05/2022", time: "04:59", order_service: first_order)
    second_route = OrderRoute.create!(coordinates: "-16.6468, -47.3537", date: "29/05/2022", time: '18:39', order_service: first_order)
    user = User.create!(name: 'Miguel', email: 'miguel@saomiguel.com.br', password: 'password')
    login_as(user, scope: :user)
    
    visit new_order_service_order_route_path(first_order)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Página não existe'

  end

  it 'e volta pra página de detalhes de pedido' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1)
    first_route = OrderRoute.create!(coordinates: "-16.6865, -49.4537", date: "28/05/2022", time: "04:59", order_service: first_order)
    

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens de Serviço Aceitas'
    click_on "Pedido #{first_order.code}"
    click_on 'Atualizações de rota'
    click_on 'Adicionar nova Atualização de Rota'
    click_on 'Voltar'

    expect(current_path).to eq order_service_order_routes_path(first_order)

  end
end