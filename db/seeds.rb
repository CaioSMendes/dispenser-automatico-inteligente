# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)




user = User.new(email: 'user@user.com', password: 'user123', name: 'User Master', phone: '(95) 2379-7154', role: :user)
user.save
puts 'User Master criado com sucesso!'

user = User.new(email: 'caio@user.com', password: 'user123', name: 'User Big Master', phone: '(49) 2321-8336', role: :user)
user.save
puts 'User Big Master criado com sucesso!'

user = User.new(email: 'top@user.com', password: 'user123', name: 'Top User Big Master', phone: '(49) 2321-8336', role: :user)
user.save
puts 'User Big Master criado com sucesso!'


admin = User.new(email: 'admin@admin.com', password: 'admin123', name: 'Admin Big Master', phone: '(49) 2321-8336', role: :admin)
admin.save
puts 'Admin Big Master criado com sucesso!'

admin = User.new(email: 'caio@admin.com', password: 'admin123', name: 'Admin Big', phone: '(49) 2321-8336', role: :admin)
admin.save
puts 'Admin criado com sucesso!'

admin = User.new(email: 'top@admin.com', password: 'admin123', name: 'Top Admin Big', phone: '(49) 2321-8336', role: :admin)
admin.save
puts 'Top Admin criado com sucesso!'

puts user.user?  # true
puts admin.admin? # true

puts 'Usuários criados com sucesso!'


Seller.create(
  status: "Ativo",
  nome: "João",
  cardRFID: "ABCD1234",
  cargo: "Vendedor",
  contador: 0,
  email: "João@João.com"
)

Seller.create(
  status: "Ativo",
  nome: "Pedro",
  cardRFID: "ASDF6553",
  cargo: "Vendedor",
  contador: 0,
  email: "Pedro@Pedro.com"
)

Seller.create(
  status: "Ativo",
  nome: "HUGO",
  cardRFID: "TRHDV592",
  cargo: "Vendedor",
  contador: 0,
  email: "HUGO@HUGO.com"
)

Seller.create(
  status: "Ativo",
  nome: "Juca",
  cardRFID: "BFRH8953",
  cargo: "Vendedor",
  contador: 0,
  email: "Juca@Juca.com"

)

Seller.create(
  status: "Ativo",
  nome: "Igor",
  cardRFID: "VDHFLO5439",
  cargo: "Vendedor",
  contador: 0,
  email: "Igor@Igor.com"
)

DosePrice.create(price: 2.50) # Defina o valor inicial da dose aqui
