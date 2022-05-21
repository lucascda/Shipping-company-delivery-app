require 'rails_helper'

describe 'usuário se autentica' do
  it 'com sucesso' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)   
    

    User.create!(name: 'Augusto Roberto', email: 'augusto@jamef.com.br',
                password: 'password', carrier: carrier)
    visit root_path
    click_on 'Entrar'    
    within 'form' do
      fill_in 'Email', with: 'augusto@jamef.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    expect(page).to have_button 'Sair'
    expect(page).to_not have_link 'Entrar'
    expect(page).to have_content 'Logado como: augusto@jamef.com.br'
    expect(page).to have_content 'Login efetuado com sucesso'    
  end

  it 'e faz log out' do
    carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
      email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
      adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
      country: 'Brasil', status: 0)        

    User.create!(name: 'Augusto Roberto', email: 'augusto@jamef.com.br',
                password: 'password', carrier: carrier)
    visit root_path
    click_on 'Entrar'        
    within 'form' do
      fill_in 'Email', with: 'augusto@jamef.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'
    expect(page).to_not have_button 'Sair'
    expect(page).to have_content 'Logout efetuado com sucesso.'

  end

  
end