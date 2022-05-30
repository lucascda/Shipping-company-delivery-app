require 'rails_helper'

describe 'usuário não autenticado busca por ordem de serviço' do
  it 'e vê detalhes de ordem de serviço' do
    first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
        email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
        adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
        country: 'Brasil', status: 0)
      vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
        fab_year: '2007', max_cap: 100 , carrier: first_carrier)
      
    first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
            dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ', product_code: 'SA32SUMG-0231',
            volume: 0.005, weight: 5.5, carrier: first_carrier, accepted_status: 1, order_status: 1, vehicle: vehicle)
    first_route = OrderRoute.create!(coordinates: "-16.6865, -49.4537", date: "28/05/2022", time: "04:59", order_service: first_order)
    second_route = OrderRoute.create!(coordinates: "-16.6468, -47.3537", date: "29/05/2022", time: '18:39', order_service: first_order)

    visit root_path
    fill_in 'Buscar Entrega', with: first_order.code
    click_on 'Buscar'
    expect(page).to have_content "Detalhes do Pedido #{first_order.code}"
    expect(page).to have_content "Status do Pedido: Aprovado"
    expect(page).to have_content "Endereço de Retirada: #{first_order.source_adress}"
    expect(page).to have_content "Endereço de Destino: #{first_order.dest_adress}"
    expect(page).to have_content "Código de Produto: #{first_order.product_code}"
    expect(page).to have_content "Volume do Pedido: #{first_order.volume} m³"
    expect(page).to have_content "Peso do Pedido: #{first_order.weight} kg"
    expect(page).to have_content "Transportadora: #{first_order.carrier.brand_name}"
    expect(page).to have_content "Veículo: #{vehicle.plate} - #{vehicle.model}"
    expect(page).to have_content "Atualizações de Rota"
    expect(page).to have_content "Data e Hora:"
    expect(page).to have_content "28/05/2022 - 04:59"
    expect(page).to have_content "Coordenada Geográfica:"
    expect(page).to have_content "-16.6865, -49.4537"
    expect(page).to have_content "Data e Hora:"
    expect(page).to have_content "29/05/2022 - 18:39"
    expect(page).to have_content "Coordenada Geográfica:"
    expect(page).to have_content "-16.6468, -47.3537"

  end

  it 'e não encontra informações' do
    visit root_path
    fill_in 'Buscar Entrega', with: 'UDA7HSUDHU'
    click_on 'Buscar'
    expect(page).to have_content 'Não foram encontrados resultados para essa busca'

  end
end