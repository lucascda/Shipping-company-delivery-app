require 'rails_helper'

describe 'administrador do sistema se autentica' do
  it 'com sucesso' do
    Admin.create!(name: 'Pedro Augusto', email: 'pedro@sistemadefrete.com.br', password: 'password')
    visit root_path
    click_on 'Acesso Restrito'
    within 'form' do
      fill_in 'Email', with: 'pedro@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    expect(page).to have_button 'Sair'
    expect(page).not_to have_link 'Acesso Restrito'
    expect(page).to have_content 'Logado como admin: pedro@sistemadefrete.com.br'
    expect(page).to have_content 'Painel de Administrador - Sistema de Frete'
    expect(page).to have_content 'Login efetuado com sucesso'

  end

  it 'e depois sai' do
    Admin.create!(name: 'Pedro Augusto', email: 'pedro@sistemadefrete.com.br', password: 'password')
    visit root_path
    click_on 'Acesso Restrito'
    within 'form' do
      fill_in 'Email', with: 'pedro@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content 'Logado como admin: pedro@sistemadefrete.com.br'
    expect(page).not_to have_content 'Painel de Administrador - Sistema de Frete'
    expect(current_path).to eq root_path

  end
end