require 'rails_helper'

describe 'usuário de transportadora visualiza veículos cadastrados' do
  it 'a partir do painel de usuario' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    carrier2 = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
       email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
       adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
       country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    vehicle = Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
              fab_year: '2007', max_cap: 100 , carrier: carrier)
    Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
              fab_year: '2009', max_cap: 85 , carrier: carrier)
    Vehicle.create!(plate: 'GYO-0912', brand_name: 'Renault', model: '21 TXE/ TXi 2.2',
                    fab_year: '1992', max_cap: 78, carrier: carrier2)
    login_as(user)
    visit root_path

    expect(page).to have_link 'Veículos'
    click_on 'Veículos'
    expect(current_path).to eq vehicles_path
    expect(page).to have_content 'Modelo: Camry XLE 3.5 24V Aut.'
    expect(page).to have_content 'Capacidade: 100 kg'
    expect(page).to have_content 'Modelo: Fit EXL 1.5 Flex/Flexone 16V 5p Aut'
    expect(page).to have_content 'Capacidade: 85 kg'
    expect(page).not_to have_content 'Modelo: 21 TXE/ TXi 2.2'
    expect(page).not_to have_content 'Capacidade: 78 kg'
  end

  it 'e não vê veículos cadastrados' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)
    user = User.create!(name: 'João Paulo', email: 'joaopaulo@jamef.com.br', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Veículos'
    expect(page).to have_content 'Não há veículos cadastrados.'


  end
end