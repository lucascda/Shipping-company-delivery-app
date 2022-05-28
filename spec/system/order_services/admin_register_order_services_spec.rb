require 'rails_helper'

describe 'admin do sistema registra nova ordem de serviço' do
  it 'a partir do menu inicial' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar nova Ordem de Serviço'

    expect(page).to have_content 'Cadastro de Ordem de Serviço'
    expect(page).to have_field 'Endereço de Retirada'
    expect(page).to have_field 'Endereço de Destino'
    expect(page).to have_field 'Código de Produto'
    expect(page).to have_field 'Volume do Pedido'
    expect(page).to have_field 'Peso do Pedido'
    expect(page).to have_field 'Transportadora'
    expect(page).to have_button 'Enviar'
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
    third_carrier = Carrier.create!(corporate_name: 'Entregadora Desativada ltda.',
        brand_name: 'Expresso Desativado', email_domain: 'www.desativada.com.br',
        registration_number: '88998774000102', adress: 'Av. Desativada, 300',
        city: 'Blank City', state: 'MG', country: 'Brasil', status: 1)
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar nova Ordem de Serviço'

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC12345')
    fill_in 'Endereço de Retirada', with: 'Rua de um Galpão, 300, Belo Horizonte, MG'
    fill_in 'Endereço de Destino', with: 'Rua do Cliente, 240A, Blumenau, SC'
    fill_in 'Código de Produto', with: 'SAMSU32-TV3404-H7HS'
    fill_in 'Volume do Pedido', with: '0.007'
    fill_in 'Peso do Pedido', with: '7.4'
    select 'São Miguel', from: 'Transportadora'

    click_on 'Enviar'
    expect(page).to have_content 'Ordem de Serviço cadastrada com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Pendente de Aceite: Aguardando aceitação'
    expect(page).to have_content 'Status do Pedido: Aguardando aprovação'
    expect(page).to have_content 'Endereço de Retirada: Rua de um Galpão, 300, Belo Horizonte, MG'
    expect(page).to have_content 'Endereço de Destino: Rua do Cliente, 240A, Blumenau, SC'
    expect(page).to have_content 'Código de Produto: SAMSU32-TV3404-H7HS'
    expect(page).to have_content 'Volume do Pedido: 0.007 m³'
    expect(page).to have_content 'Peso do Pedido: 7.4 kg'
    
  end

  it 'sem sucesso e vê erros' do
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
    third_carrier = Carrier.create!(corporate_name: 'Entregadora Desativada ltda.',
        brand_name: 'Expresso Desativado', email_domain: 'www.desativada.com.br',
        registration_number: '88998774000102', adress: 'Av. Desativada, 300',
        city: 'Blank City', state: 'MG', country: 'Brasil', status: 1)
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar nova Ordem de Serviço'

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABC12345')
    fill_in 'Endereço de Retirada', with: ''
    fill_in 'Endereço de Destino', with: ''
    fill_in 'Código de Produto', with: ''
    fill_in 'Volume do Pedido', with: ''
    fill_in 'Peso do Pedido', with: ''
    

    click_on 'Enviar'
    expect(page).to have_content 'Ordem de Serviço não pôde ser criada'
    expect(page).to have_content 'Endereço de Retirada não pode ficar em branco'
    expect(page).to have_content 'Endereço de Destino não pode ficar em branco'
    expect(page).to have_content 'Código de Produto não pode ficar em branco'
    expect(page).to have_content 'Volume do Pedido não pode ficar em branco'
    expect(page).to have_content 'Peso do Pedido não pode ficar em branco'
    expect(page).to have_content 'Volume do Pedido não pode ficar em branco'
    expect(page).to have_content 'Volume do Pedido não pode ficar em branco'
    
    
  end

  it 'e volta pra página de ordens de serviço' do
    admin = Admin.create!(name: 'Fulano', email: 'fulano@sistemadefrete.com.br', password: 'password')
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar nova Ordem de Serviço'
    click_on 'Voltar'
    expect(current_path).to eq order_services_path
    
  end

end