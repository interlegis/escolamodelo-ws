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

{
	"type_conversation": "dúvida",
	"title": "RESP1",
  "school_initials": "APP",
  "course_id": "2",
  "course_category_id": "1",
  "description": "TEST1.",
  "cpf": "0453232668124",
	"name": "Matheus Roberto",
	"email": "roberto.matheus@bol.com.br",
	"is_student": "false",
}

@conversa1 = ContactUsConversation.create(type_conversation: "dúvida", title: "Não consigo acessar o moodle", school_initials: "SSL", course_id: "1", description: "O que fazer para ter acesso as aulas", cpf: "0452285554", name: "Morfeus", email: "MorfeusNeo@gmail.com")
ContactUsConversation.create(type_conversation: "reclamação", title: "O site apresenta um layout muito desagradável", school_initials: "HTT", course_id: "2", description: "O design do site poderia ser mudado para um modelo parecido com o do facebook.", cpf: "123123132", name: "Rezinaldo", email: "reizão@gmail.com")
ContactUsConversation.create(type_conversation: "sugestão", title: "Melhorar o curso de Web", school_initials: "SSL", course_id: "1", description: "O curso de web poderia apresentar a linguagem javascript.", cpf: "0452285554", name: "Zilmar", email: "Zilmar@gmail.com")
ContactUsConversation.create(type_conversation: "dúvida", title: "Posso passar a senha do meu moodle para um amigo?", school_initials: "SSL", course_id: "1", description: "Gostaria de saber se eu posso passar a senha do moodle para que um amigo também possa participar das atividades.", cpf: "0452285554", name: "Sassá", email: "sassa@gmail.com")

@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'Tente acessar novamente, liberei o seu acesso.', is_student: 'false')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Morfeus', email: 'morfeusNeo@gmail.com', cpf: '4564564545', description: 'Tentei e continuo sem acesso.', is_student: 'true')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'Tinha esquecido de liberar, agora pode tentar mesmo.', is_student: 'false')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Morfeus', email: 'morfeusNeo@gmail.com', cpf: '4564564545', description: 'Obrigado, agora eu consegui.', is_student: 'true')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'De nada.', is_student: 'false')
