require 'rails_helper'

describe 'usuário edita preços' do
  it 'se autenticado' do
    carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
        upper_weight: 10, price_per_km: 0.5, carrier: carrier1)
    visit edit_shipping_price_path(price)
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela inicial' do    
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
        upper_weight: 10, price_per_km: 0.5, carrier: carrier)
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(joao, scope: :user)
    visit root_path
    click_on 'Preços'
    click_on 'Editar Preço 1'
    expect(page).to have_field 'Volume mínimo', with: '0.001'
    expect(page).to have_field 'Volume máximo', with: '0.005'
    expect(page).to have_field 'Peso mínimo', with: '0.1'
    expect(page).to have_field 'Peso máximo', with: '10.0'
    expect(page).to have_field 'Preço por km', with: '0.5'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
        upper_weight: 10, price_per_km: 0.5, carrier: carrier)
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(joao, scope: :user)
    visit root_path
    click_on 'Preços'
    click_on 'Editar Preço 1'
    fill_in 'Volume mínimo', with: '0.005'
    fill_in 'Volume máximo', with: '0.010'
    fill_in 'Peso mínimo', with: '5'
    fill_in 'Peso máximo', with: '15'
    fill_in 'Preço por km', with: '0.75'
    click_on 'Salvar'

    expect(page).to have_content 'Preço atualizado com sucesso'
    expect(page).not_to have_content '0.001 - 0.005'
    expect(page).not_to have_content '0 a 10 kg'
    expect(page).not_to have_content 'R$ 0.5'
    expect(page).to have_content '0.005 - 0.01'
    expect(page).to have_content '5.0 a 15.0 kg'
    expect(page).to have_content 'R$ 0.75'

  end

  it 'sem sucesso e vê erros' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
        upper_weight: 10, price_per_km: 0.5, carrier: carrier)
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    
    login_as(joao, scope: :user)
    visit root_path
    click_on 'Preços'
    click_on 'Editar Preço 1'
    fill_in 'Volume mínimo', with: ''
    fill_in 'Volume máximo', with: ''
    fill_in 'Peso mínimo', with: '7.5'
    fill_in 'Peso máximo', with: '4.5'
    fill_in 'Preço por km', with: '-1'
    click_on 'Salvar'
    expect(page).to have_content 'Preço não foi atualizado'
    expect(page).to have_content 'Volume mínimo não pode ficar em branco'
    expect(page).to have_content 'Volume máximo não pode ficar em branco'
    expect(page).to have_content 'Preço por km deve ser maior que 0'
    expect(page).to have_content 'Peso mínimo deve ser menor que 4.5'
    expect(page).to have_content 'Peso máximo deve ser maior que 7.5'
  end
  
  it 'e não atualiza preços de outras transportadoras' do
    carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    carrier2 = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
        email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
        adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
        country: 'Brasil', status: 0)
    price1 = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
            upper_weight: 10, price_per_km: 0.5, carrier: carrier1)
    price2 = ShippingPrice.create!(bottom_volume: 0.005, upper_volume: 0.010, bottom_weight: 10, 
              upper_weight: 30, price_per_km: 0.8, carrier: carrier2)
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    paulo = User.create!(name: 'Paulo', email: 'joaopaulo@saomiguel.com.br', password: 'password')
    login_as(joao, scope: :user)
    visit edit_shipping_price_path(price2.id)
    expect(page).not_to eq edit_shipping_price_path(price2.id)    
    expect(page).to have_content 'Preço não encontrado'

  end
  
end