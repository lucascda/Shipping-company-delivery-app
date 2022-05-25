require 'rails_helper'

describe 'usuário se cadastra' do
  it 'a partir da tela inicial' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)    
   
    
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastre-se'

    fill_in 'Nome', with: 'Augusto Reis'   
    fill_in 'Senha', with: 'password'
    fill_in 'Email', with: 'augusto@jamef.com.br'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    expect(page).to have_content 'augusto@jamef.com.br'
  end
end