# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
  email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
  adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
  country: 'Brasil', status: 0)
carrier2= Carrier.create!(corporate_name: 'Expresso São Miguel S/A', brand_name: 'São Miguel',
    email_domain: 'www.saomiguel.com.br',registration_number: '00428307001917',
    adress: 'AC Plínio Arlindo de Nes, 2180D, Belvedere', city: 'Chapecó', state: 'Santa Catarina',
    country: 'Brasil', status: 0)
Vehicle.create!(plate: 'GOX-1793', brand_name: 'Toyota' , model: 'Camry XLE 3.5 24V Aut.',
      fab_year: '2007', max_cap: 100 , carrier: carrier)
Vehicle.create!(plate: 'GYO-0912', brand_name: 'Renault', model: '21 TXE/ TXi 2.2',
        fab_year: '1992', max_cap: 78, carrier: carrier2)
User.create!(name: 'Lucas', email: 'lucas@jamef.com.br', password: 'password')
User.create!(name: 'João', email: 'joao@saomiguel.com.br', password: 'password')

