# Duas transportadoras
first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
  email_domain: 'www.jamef.com.br',registration_number: '20137617002276',
  adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
  country: 'Brasil', status: 0)
second_carrier = Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
    email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
    adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
    country: 'Brasil', status: 0)

# Dois veículos
Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
      fab_year: '2007', max_cap: 100 , carrier: first_carrier)
Vehicle.create!(plate: 'GYO-0912', brand_name: 'Renault', model: '21 TXE/ TXi 2.2',
        fab_year: '1992', max_cap: 78, carrier: second_carrier)

# Dois usuários de transportadora
User.create!(name: 'Lucas', email: 'lucas@jamef.com.br', password: 'password')
User.create!(name: 'João', email: 'joao@saomiguel.com.br', password: 'password')

# Um usuário administrador
Admin.create!(name: 'Lucas', email:'lucas@sistemadefrete.com.br', password: 'password')

# Duas ordens de serviço
first_order = OrderService.create!(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
  dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',product_code: 'SA32SUMG-0231',
  volume: 0.005, weight: 5.5, carrier: first_carrier)
second_order = OrderService.create!(source_adress: 'Avenida dos Girassóis 50,Residencial Sun Flower, Anápolis, GO',
  dest_adress: 'Rua Dos Bobos, São Paulo, SP ',
  volume: 0.003, weight: 4.3, carrier: second_carrier, product_code: 'XIA414-OMI-9484')

# Dois prazos de entrega
first_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 2, carrier: first_carrier)
second_delivery_time = DeliveryTime.create!(bottom_distance: 0, upper_distance: 100, working_days: 5, carrier: second_carrier)

# Dois preços de entrega
first_price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.005, bottom_weight: 0.1, 
  upper_weight: 10, price_per_km: 0.5, carrier: first_carrier)
second_price = ShippingPrice.create!(bottom_volume: 0.001, upper_volume: 0.05, bottom_weight: 0.1, 
    upper_weight: 15, price_per_km: 0.8, carrier: second_carrier)

# Duas atualizações de rotas

first_route = OrderRoute.create!(coordinates: "-16.6865, -49.4537", date: "28/05/2022", time: "04:59", order_service: first_order)
second_route = OrderRoute.create!(coordinates: "-16.6468, -47.3537", date: "29/05/2022", time: '18:39', order_service: second_order)

