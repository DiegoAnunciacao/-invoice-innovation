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

client_name = [
  "Ana Silva", "João Souza", "Maria Oliveira", "Carlos Pereira", "Lucas Costa",
  "Fernanda Santos", "Mariana Rodrigues", "Ricardo Almeida", "Beatriz Nascimento", "Gabriel Lima",
  "Camila Carvalho", "Pedro Ribeiro", "Larissa Martins", "Rafael Rocha", "Julia Barbosa",
  "Tiago Dias", "Sofia Andrade", "Leonardo Monteiro", "Isabela Cardoso", "Felipe Gomes",
  "Carolina Santos", "André Almeida", "Juliana Souza", "Henrique Pereira", "Bianca Rocha",
  "Mateus Ribeiro", "Patrícia Carvalho", "Eduardo Monteiro", "Clara Martins", "Roberto Cardoso",
  "Sara Nascimento", "Daniel Oliveira", "Marcela Dias", "Rodrigo Gomes", "Larissa Costa"
]

painting_services = [
  "Pintura residencial externa",
  "Pintura residencial interna",
  "Pintura comercial externa",
  "Pintura comercial interna",
  "Aplicação de textura em paredes",
  "Pintura de teto com acabamento liso",
  "Pintura decorativa com stencil",
  "Pintura com efeito ombré",
  "Reparo e pintura de paredes com mofo",
  "Selagem e pintura de superfícies porosas",
  "Pintura à base de óleo para superfícies metálicas",
  "Pintura com tinta epóxi para pisos",
  "Pintura de portões metálicos",
  "Pintura de grades de janelas",
  "Pintura de fachadas de prédios",
  "Pintura com tinta impermeabilizante",
  "Pintura de azulejos de cozinha",
  "Pintura de azulejos de banheiro"
]


1.times do |u|
  user = User.create!(
    first_name: "Carter",
    last_name: "Anunciacao",
    email: "carterfotografia@gmail.com",
    password: "teste123",
    phone: "3530892338481",
    company_name: "Carter Photography",
    company_address: "32 Ard Cluain, Main Street, Clonee, Co. Meath, Ireland",
    company_number: Faker::Company.brazilian_company_number,
    image_logo: Faker::Avatar.image
  )

  client_name.each do |n|
    email = n.downcase.gsub(" ", ".") + ["@gmail.com", "@hotmail.com", "@yahoo.com"].sample
    client = Client.create!(
      name: n,
      address: Faker::Address.street_address,
      county: Faker::Address.city,
      email: email,
      postcode: Faker::Address.postcode,
      phone: Faker::PhoneNumber.phone_number,
      user: user
      )

      2.times do |i|
        invoice = Invoice.new(
        notes: "",
        vat: rand(12..20),
        client: client
        )

        2.times do |s|
          description = painting_services.sample
          Service.create!(
            description: description,
            amount: rand(10..1000),
            invoice: invoice
          )
        end
        invoice.save
      end
    end
  end

puts "Users, Clients, Invoices and Services created"
