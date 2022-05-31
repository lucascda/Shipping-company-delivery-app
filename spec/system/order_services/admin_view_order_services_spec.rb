require 'rails_helper'

describe 'usuário administrador vê ordens de serviço' do
  it 'se autenticado' do
    visit order_services_path
    expect(current_path).to eq new_admin_session_path
  end

  it 'com sucesso' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

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
                  volume: 0.005, weight: 5.5, carrier: first_carrier,accepted_status: 1, order_status: 1, vehicle: first_vehicle)
    second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
                  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
                  volume: 0.003, weight: 4.3, carrier: first_carrier, order_status: 0, accepted_status: 0 , product_code: 'XIA414-OMI-9484',vehicle: nil )    
    third_order = OrderService.create!(source_adress: 'Avenida Esther Castilho Marques 45, Cidade de Deus, Sete Lagoas, MG',
                  dest_adress: 'Rua Voluntários da Pátria 89, Bom Retiro, Blumenau, SC',
                  volume: 0.025, weight: 18.5, carrier: second_carrier, order_status: 1,
                  vehicle: nil, accepted_status: 1, product_code: 'ACER-3275-8JA8')
    fourth_order = OrderService.create!(source_adress: 'Rua Sete 25, Planalto II, Ipatinga, MG',
                   dest_adress: 'Conjunto Iguatemi 35, Uruguai, Teresina, PI',
                   volume: 0.007, weight: 4.25, carrier: second_carrier,accepted_status: 1, order_status: 2, product_code: 'LIG-HT4848-3331')
    
    visit root_path
    click_on 'Ordens de Serviço'
    expect(page).to have_content 'Ordens de Serviço'    
    expect(page).to have_content "Pedido #{first_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aceitação alterada'
    expect(page).to have_content 'Status do Pedido: Aprovado'    
    expect(page).to have_content "Pedido #{second_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aguardando aceitação'
    expect(page).to have_content 'Status do Pedido: Aguardando aprovação'    
    expect(page).to have_content "Pedido #{third_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aceitação alterada'
    expect(page).to have_content 'Status do Pedido: Aprovado'
    expect(page).to have_content "Pedido #{fourth_order.code}"
    expect(page).to have_content 'Pendente de Aceite: Aceitação alterada'
    expect(page).to have_content 'Status do Pedido: Recusado'
    
    

  end

  it 'e não vê ordens de serviços cadastradas' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Ordens de Serviço'
    expect(page).to have_content 'Não há Ordens de Serviço cadastradas'

  end

  it 'e volta pra página inicial' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Voltar'
    expect(current_path).to eq root_path
    
  end

end