# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
carrier1 = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
  email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
  adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
  country: 'Brasil', status: 0)


