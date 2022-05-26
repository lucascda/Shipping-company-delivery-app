require 'rails_helper'

describe 'usuário de transportadora visualiza preços' do
  it 'cadastrados com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
                              email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
                              adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
                              country: 'Brasil', status: 0)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
                                 upper_weight: 10, price_per_km: 0.5, carrier: carrier)
    price2 = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 10, 
                                  upper_weight: 30, price_per_km: 0.8, carrier: carrier)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Preços'
    expect(current_path).to eq shipping_prices_path
    expect(page).to have_content 'Metros cúbicos | Preços | Valor por km'
    expect(page).to have_content '0.001 - 0.005'
    expect(page).to have_content '0.1 a 10.0 kg'
    expect(page).to have_content 'R$ 0.5'
    expect(page).to have_content '0.001 - 0.005'
    expect(page).to have_content '10.0 a 30.0 kg'
    expect(page).to have_content 'R$ 0.8'

  end

  it 'e não há preços cadastrados' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Preços'
    expect(page).to have_content 'Não há preços cadastrados'    
  end

  it 'e visualiza somente os seus próprios preços cadastrados' do
    carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    carrier2 = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
        email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
        adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
        country: 'Brasil', status: 0)
    price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
            upper_weight: 10, price_per_km: 0.5, carrier: carrier1)
    price2 = ShippingPrice.create!(bottom_volume: 0.005, upper_volume: 0.010, bottom_weight: 10, 
              upper_weight: 30, price_per_km: 0.8, carrier: carrier2)
    joao = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    paulo = User.create!(name: 'Paulo', email: 'joaopaulo@saomiguel.com.br', password: 'password')
    login_as(joao, scope: :user)
    visit root_path
    click_on 'Preços'
    expect(page).to have_content 'Metros cúbicos | Preços | Valor por km'
    expect(page).not_to have_content '0.005 - 0.010'
    expect(page).not_to have_content '10 a 30 kg'
    expect(page).not_to have_content 'R$ 0.8'
    expect(page).to have_content '0.001 - 0.005'
    expect(page).to have_content '0.1 a 10.0 kg'
    expect(page).to have_content 'R$ 0.5'

  end
  it 'e volta pra tela inicial' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)

    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Preços'
    click_on 'Voltar'
    expect(current_path).to eq root_path
    
  end
end