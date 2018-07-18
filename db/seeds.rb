# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create(name: 'admin')
Role.create(name: 'usuario')
User.create(username: 'admin', first_name: 'Admin', last_name: 'Admin', cpf: '000.000.000-00', phone: '(00) 90000-0000', email: 'admin@admin.com', role_id: 1, password: 'admin123')