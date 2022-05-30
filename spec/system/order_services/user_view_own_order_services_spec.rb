require 'rails_helper'

describe 'usuário de transportadora vê ordens de serviço pendentes' do
  it 'se autenticado' do
    visit users_index_order_services_path
    expect(current_path).to eq new_user_session_path
  end

  it 'de sua transportadora' do 

    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    second_carrier = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
       email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
       adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
       country: 'Brasil', status: 0)
    first_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
        fab_year: '2009', max_cap: 85 , carrier: first_carrier)
    second_vehicle = Vehicle.create!(plate: 'GYO-0912', brand_name: 'Renault', model: '21 TXE/ TXi 2.2',
              fab_year: '1992', max_cap: 78, carrier: second_carrier)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',product_code: 'SA32SUMG-0231',
                  volume: 0.005, weight: 5.5, carrier: first_carrier)
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
                  volume: 0.003, weight: 4.3, carrier: first_carrier,product_code: 'XIA414-OMI-9484',vehicle: nil )    
    third_order = OrderService.create!(source_adress: 'Avenida Esther Castilho Marques 45, Cidade de Deus, Sete Lagoas, MG',
                  dest_adress: 'Rua Voluntários da Pátria 89, Bom Retiro, Blumenau, SC',
                  volume: 0.025, weight: 18.5, carrier: second_carrier, order_status: 1,
                  vehicle: nil, accepted_status: 1, product_code: 'ACER-3275-8JA8')
    fourth_order = OrderService.create!(source_adress: 'Rua Sete 25, Planalto II, Ipatinga, MG',
                   dest_adress: 'Conjunto Iguatemi 35, Uruguai, Teresina, PI',
                   volume: 0.007, weight: 4.25, carrier: second_carrier,accepted_status: 1, order_status: 2, product_code: 'LIG-HT4848-3331')
    
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    expect(page).to have_content 'Ordens de Serviço - Jamef'
    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content "Endereço de Retirada: #{first_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{first_order.dest_adress}"
    expect(page).to have_content "Volume do Pedido: #{first_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{first_order.weight} kg"

    expect(page).not_to have_content "Pedido #{third_order.code}"
    expect(page).not_to have_content "Endereço de Retirada: #{third_order.source_adress}"
    expect(page).not_to have_content "Endereço de Destino: #{third_order.dest_adress}"
    expect(page).not_to have_content "Volume do Pedido: #{third_order.volume} m³"
    expect(page).not_to have_content "Peso do Pedido: #{third_order.weight} kg"

    expect(page).to have_content "Pedido #{second_order.code}"
    expect(page).to have_content "Endereço de Retirada: #{second_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{second_order.dest_adress}"
    expect(page).to have_content "Volume do Pedido: #{second_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{second_order.weight} kg"    

  end

  it 'e não vê ordens de serviços pendentes' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    expect(page).to have_content 'Não há Ordens de Serviço pendentes'
    
  end
  
  it 'somente se o status for pendente de aceitação' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier)
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
          volume: 0.003, weight: 4.3, carrier: first_carrier,product_code: 'XIA414-OMI-9484')    
    third_order = OrderService.create!(source_adress: 'Avenida Esther Castilho Marques 45, Cidade de Deus, Sete Lagoas, MG',
          dest_adress: 'Rua Voluntários da Pátria 89, Bom Retiro, Blumenau, SC',
          volume: 0.025, weight: 18.5, carrier: first_carrier,order_status: 1,
          accepted_status: 1, product_code: 'ACER-3275-8JA8')
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'

    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content "Endereço de Retirada: #{first_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{first_order.dest_adress}"
    expect(page).to have_content "Volume do Pedido: #{first_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{first_order.weight} kg"

    expect(page).not_to have_content "Pedido #{third_order.code}"
    expect(page).not_to have_content "Endereço de Retirada: #{third_order.source_adress}"
    expect(page).not_to have_content "Endereço de Destino: #{third_order.dest_adress}"
    expect(page).not_to have_content "Volume do Pedido: #{third_order.volume} m³"
    expect(page).not_to have_content "Peso do Pedido: #{third_order.weight} kg"

    expect(page).to have_content "Pedido #{second_order.code}"
    expect(page).to have_content "Endereço de Retirada: #{second_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{second_order.dest_adress}"
    expect(page).to have_content "Volume do Pedido: #{second_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{second_order.weight} kg"
  end

  it 'e volta pra tela de ordens de serviços' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Voltar'
    expect(current_path).to eq root_path

  end


end

describe 'usuário de transportadora vê ordens de serviço aceitas' do
  it 'se autenticado' do
    visit accepted_orders_order_services_path
    expect(current_path).to eq new_user_session_path

  end

  it 'a partir da tela inicial' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
          dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
          volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1)
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
          dest_adress: 'Rua que não pode',
          volume: 0.003, weight: 4.3, carrier: first_carrier,product_code: 'XIA414-OMI-9484', accepted_status: 1, order_status: 2,)    
    third_order = OrderService.create!(source_adress: 'Avenida Esther Castilho Marques 45, Cidade de Deus, Sete Lagoas, MG',
          dest_adress: 'Rua Voluntários da Pátria 89, Bom Retiro, Blumenau, SC',
          volume: 0.025, weight: 18.5, carrier: first_carrier,order_status: 1,
          accepted_status: 1, product_code: 'ACER-3275-8JA8')
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens de Serviço Aceitas'
    
    expect(page).to have_content 'Ordens de Serviço Aceitas'
    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content "Endereço de Retirada: #{first_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{first_order.dest_adress}"
    expect(page).to have_content "Volume do Pedido: #{first_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{first_order.weight} kg"

    
    expect(page).not_to have_content "Pedido #{second_order.code}"
    expect(page).not_to have_content "Endereço de Retirada: #{second_order.source_adress}"
    expect(page).not_to have_content "Endereço de Destino: #{second_order.dest_adress}"
    expect(page).not_to have_content "Volume do Pedido: #{second_order.volume} m³"
    expect(page).not_to have_content "Peso do Pedido: #{second_order.weight} kg"

    
    expect(page).to have_content "Pedido #{third_order.code}"
    expect(page).to have_content "Endereço de Retirada: #{third_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{third_order.dest_adress}"
    expect(page).to have_content "Volume do Pedido: #{third_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{third_order.weight} kg"

  end

  it 'e não vê ordens de serviço aceitas' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens de Serviço Aceitas'

    expect(page).to have_content 'Não há Ordens de Serviço aceitas'
  end

  it 'e volta pra tela de ordens de serviço' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens de Serviço Aceitas'
    click_on 'Voltar'
    expect(current_path).to eq users_index_order_services_path

    
  end

  
end