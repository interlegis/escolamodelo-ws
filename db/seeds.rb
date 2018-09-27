# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
Role.create(name: 'admin')
Role.create(name: 'usuario')
  User.create(first_name: 'Admin', last_name: 'Admin', cpf: '000.000.000-00', phone: '(00) 90000-0000', email: 'admin@admin.com', role_id: 1, password: 'admin123')
s=School.create(name: 'Saberes', url: 'https://saberes.senado.leg.br', initials: 'SSL')
s.logo.attach(
    io: open('https://saberes.senado.leg.br/images/logo_saberes_xl.png'),
    filename: 'logo_saberes.png',
    content_type: 'image/png'
)
s=School.create(name: 'Escola do Legislativo - ALMG', url: 'https://ead.almg.gov.br/moodle/', initials: 'ALM')
s.logo.attach(
    io: open('http://ead.almg.gov.br/moodle/theme/image.php/fadeback/theme/1479830583/logo'),
    filename: 'logo_almg.png',
    content_type: 'image/png'
)
s=School.create(name: 'EaD Senac', url: 'http://www.ead.senac.br/', initials: 'EAS')
s.logo.attach(
    io: open('http://folhadealagoas.com.br/portal/wp-content/uploads/2017/08/senac.jpg'),
    filename: 'logo_senac.jpg',
    content_type: 'image/jpg'
)
cat=CourseCategory.create(name: 'Meio Ambiente')
cat.logo.attach(
    io: open('https://static.todamateria.com.br/upload/te/rr/terra1.jpg'),
    filename: 'logo_cat_meio_ambiente.jpg',
    content_type: 'image/jpg'
)
cat=CourseCategory.create(name: 'Saúde')
cat.logo.attach(
    io: open('http://envolverde.cartacapital.com.br/wp-content/uploads/saude-1.jpg'),
    filename: 'logo_cat_saude.jpg',
    content_type: 'image/jpg'
)
cat=CourseCategory.create(name: 'Doutrinas Políticas')
cat.logo.attach(
    io: open('https://2.bp.blogspot.com/-4JP1mOWw2bk/WOqMTDF4keI/AAAAAAABR6g/dF8hEdmDoL8wH-Iz1VhQsyGFqGheiT0uACLcB/s1600/%252BPostagem%2B046.jpg'),
    filename: 'logo_cat_doutrinas_politicas.jpg'
)
Course.create(name: 'Liberalismo', url: 'https://saberes.senado.leg.br/course/view.php?id=1381', school_id: 1, course_category_id: 3, course_load: 20, description: 'Definir, analisar e discutir o significado das principais correntes de pensamento que inspiram e orientam os partidos políticos de maior expressão - em termos de influência, voto e acesso ao poder - no mundo atual.')

ContactUsConversation.create(title: "Ronaldo alves", description: "O que fazer para ter acesso as aulas", initial_date: "11/05/2018", created_at: "2018-09-20T17:55:30.030Z", updated_at: "2018-09-20T17:55:30.030Z")
ContactUsConversation.create(title: "Robinho Soares", description: "Como posso recuperar a senha do moodle?", initial_date: "18/05/2018", created_at: "2018-09-20T17:55:30.030Z", updated_at: "2018-09-20T17:55:30.030Z")
ContactUsConversation.create(title: "Raimundinho Dias", description: "É possível baixar todo o moodle da disciplina EDA para o meu computador?", initial_date: "20/05/2018", created_at: "2018-09-20T17:55:30.030Z", updated_at: "2018-09-20T17:55:30.030Z")
ContactUsMessage.create(name: 'Everaldo Dias', email: 'everaldin@gmail.com', cpf: '0236958745', school_initials:'SSL', course_id:1, course_category_id: 1, description: 'Estava em sala e a professora não passou a chamada.', date: '09/08/2018')
ContactUsMessage.create(name: 'Matheus Roberto', email: 'matheus@gmail.com', cpf: '04523269157', school_initials:'SSL', course_id:2, course_category_id: 1, description: 'O curso de estutura de dados está excelente com o professor Clodovil.', date: '19/06/2018')
ContactUsMessage.create(name: 'Ronaldo de Assis', email: 'ronaldinho@gmail.com', cpf: '0255948745', school_initials:'ALM', course_id:1, course_category_id: 1, description: 'Não consigo acessar o moodle.', date: '10/05/2018')
ContactUsMessage.create(name: 'Raimundo Alves', email: 'raimundo@gmail.com', cpf: '8864124515', school_initials:'EAS', course_id:1, course_category_id: 1, description: 'Gostaria de saber o email do professor Oliersson.', date: '23/09/2018')
ContactUsMessage.create(name: 'Claiderson Sandres', email: 'claiderssin@gmail.com', cpf: '4836958755', school_initials:'ALM', course_id:1, course_category_id: 1, description: 'Como faço para sair do curso?', date: '04/08/2018')
