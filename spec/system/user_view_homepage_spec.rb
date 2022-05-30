require 'rails_helper'

describe 'usuário vê página inicial' do
  it 'clica no nome da empresa ' do
    visit root_path
    expect(page).to have_content 'Sistema de Frete'
    expect(page).to have_link 'Sistema de Frete', href: root_path
  end
end