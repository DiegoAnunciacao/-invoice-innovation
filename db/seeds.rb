# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "creating Users, Clients, Invoices and Services"

5.times do |u|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "teste123",
    phone: Faker::PhoneNumber,
    company_name: Faker::Company.name,
    company_address: Faker::Address.street_address,
    company_number: Faker::Company.brazilian_company_number,
    image_logo: Faker::Company.logo
  )

  2.times do |c|
    client = Client.create!(
      client_name: Faker::Name.name,
      client_address: Faker::Address.street_address,
      client_county: Faker::Address.city,
      client_email: Faker::Internet.unique.email,
      client_postcode: Faker::Address.postcode,
      client_phone: Faker::PhoneNumber,
      user: user
      )

      2.times do |i|
        invoice = Invoice.create!(
        notes: "this is a note",
        vat: rand(12..20),
        client: client
        )

        2.times do |s|
          Service.create!(
            description: "This is a description",
            amount: rand(10..1000),
            invoice: invoice
          )
        end
      end
    end
  end

puts "Users, Clients, Invoices and Services created"
