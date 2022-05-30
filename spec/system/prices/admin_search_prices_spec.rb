require 'rails_helper'

describe 'administrador de sistema consulta preços' do
  it 'a partir do painel de admin' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Consultar preços'
    expect(page).to have_content 'Consulta de Preços'
    expect(page).to have_field 'Volume'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Distância total'
    expect(page).to have_button 'Pesquisar Preços'
  end

  it 'se autenticado como admin' do
    visit search_shipping_prices_path
    expect(current_path).to eq new_admin_session_path
  end

  it 'e mostra o cálculo de frete de transportadoras ativas' do
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
    third_carrier = Carrier.create!(corporate_name: 'Compania Desativada', brand_name: 'Desativa',
       email_domain: 'www.desativada.com.br',registration_number: '00428307044917',
       adress: 'Av desativada, pampulha', city: 'Belo Horizonte', state: 'Minas Gerais',
       country: 'Brasil', status: 1)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
        upper_weight: 10, price_per_km: 0.5, carrier: first_carrier)
    price2 = ShippingPrice.create!(bottom_volume: 0.005, upper_volume: 0.010, bottom_weight: 11, 
          upper_weight: 30, price_per_km: 0.8, carrier: first_carrier)
    price3 = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
            upper_weight: 10, price_per_km: 1.25, carrier: second_carrier)
    price4 = ShippingPrice.create!(bottom_volume: 0.020, upper_volume: 0.035, bottom_weight: 40, 
            upper_weight: 60, price_per_km: 1.9, carrier: second_carrier)
    price3 = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.010, bottom_weight: 0.1, 
              upper_weight: 10, price_per_km: 0.7, carrier: third_carrier)
    
    visit root_path
    click_on 'Consultar preços'
    fill_in 'Volume', with: '0.003'
    fill_in 'Peso', with: '5.0'
    fill_in 'Distância total', with: '100'
    click_on 'Pesquisar Preços'

    expect(page).to have_content 'Transportadora: Jamef'
    expect(page).to have_content 'Preço de frete: R$ 50.0'
    expect(page).to have_content 'Transportadora: São Miguel'
    expect(page).to have_content 'Preço de frete: R$ 125.0'
    expect(page).not_to have_content 'Preço de frete: R$ 80.0'
    expect(page).not_to have_content 'Preço de frete: R$ 190.0'
    expect(page).not_to have_content 'Transportadora: Desativa'
    expect(page).not_to have_content 'Preço de frete: R$ 70.0'
  end

  it 'e também mostra o prazo de transportadoras ativas' do
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
    third_carrier = Carrier.create!(corporate_name: 'Compania Desativada', brand_name: 'Desativa',
       email_domain: 'www.desativada.com.br',registration_number: '00428307044917',
       adress: 'Av desativada, pampulha', city: 'Belo Horizonte', state: 'Minas Gerais',
       country: 'Brasil', status: 1)
    first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: first_carrier)
    second_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 300, working_days: 5, carrier: first_carrier)
    third_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 3, carrier: second_carrier)
    fourth_delivery_time = DeliveryTime.create!(bottom_distance: 101, upper_distance: 300, working_days: 6, carrier: second_carrier)
    delivery_time5 = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 1, carrier: third_carrier)
    delivery_time6 = DeliveryTime.create!(bottom_distance: 101, upper_distance: 300, working_days: 4, carrier: third_carrier)
    
    visit root_path
    click_on 'Consultar preços'
    fill_in 'Volume', with: '0.003'
    fill_in 'Peso', with: '5.0'
    fill_in 'Distância total', with: '100'
    click_on 'Pesquisar Preços'

    expect(page).to have_content 'Prazo: 2 dias úteis'
    expect(page).to have_content 'Prazo: 3 dias úteis'
    expect(page).not_to have_content 'Prazo: 5 dias úteis'
    expect(page).not_to have_content 'Prazo: 6 dias úteis'
    expect(page).not_to have_content 'Prazo: 1 dia útil'
    expect(page).not_to have_content 'Prazo: 4 dias úteis'

  end

  it 'e não encontrada resultados ' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Consultar preços'
    fill_in 'Volume', with: '0.003'
    fill_in 'Peso', with: '5.0'
    fill_in 'Distância total', with: '100'
    click_on 'Pesquisar Preços'

    expect(page).to have_content 'Não foram encontrados resultados pra essa pesquisa'
  end

  
end