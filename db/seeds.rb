require 'open-uri'
Role.create(name: 'admin')
Role.create(name: 'usuario')

User.create(cpf: '000.000.000-00')
User.create(cpf: '000.000.000-01')
User.create(cpf: "077.311.519-64", first_name: "Gabrielly", last_name: "Duarte", birth: "02-02-1977", crypted_password: "rDFcWPj1Xe", phone: "(19) 99225-5102", role_id: 2)
User.create(cpf: "403.759.851-58", first_name: "Juliana", last_name: "Rocha", birth: "07-02-1961", crypted_password: "rozliayJEF", phone: "(67) 99714-1392", role_id: 2)
User.create(cpf: "747.261.288-09", first_name: "Nelson", last_name: "Santos", birth: "07-07-1944", crypted_password: "M0Q7G5DUy2", phone: "(93) 98571-0607", role_id: 2)
User.create(cpf: "326.532.614-48", first_name: "Gustavo", last_name: "Campos", birth: "08-10-1948", crypted_password: "Ep7pNR50ZY", phone: "(84) 98201-9226", role_id: 2)
User.create(cpf: "713.823.050-87", first_name: "Isabela", last_name: "Peixoto", birth: "23-01-1985", crypted_password: "G27fpP0s02", phone: "(69) 98612-9817", role_id: 2)
User.create(cpf: "399.529.336-06", first_name: "Julio", last_name: "Fogaça", birth: "14-07-1946", crypted_password: "2It1p6uCRc", phone: "(13) 98463-2587", role_id: 2)
User.create(cpf: "502.937.715-88", first_name: "Gael", last_name: "Sales", birth: "25-08-1998", crypted_password: "eLUqJpa7xA", phone: "(65) 98890-6962", role_id: 2)
User.create(cpf: "010.026.989-36", first_name: "Pedro", last_name: "Almada", birth: "22-09-1971", crypted_password: "RMs7Kh5nhO", phone: "(82) 99301-3215", role_id: 2)
User.create(cpf: "715.839.044-68", first_name: "Valentina", last_name: "Rodrigues", birth: "18-09-1948", crypted_password: "eWMCKgAQAc", phone: "(62) 99776-6260", role_id: 2)
User.create(cpf: "513.379.539-46", first_name: "Carlos", last_name: "Vieira", birth: "08-05-1995", crypted_password: "DqYAMtANcL", phone: "(31) 98218-5736", role_id: 2)
User.create(cpf: "522.718.454-24", first_name: "Francisca", last_name: "Assunção", birth: "13-07-1980", crypted_password: "dwqseyh7TA", phone: "(86) 98921-2314", role_id: 2)
User.create(cpf: "979.192.516-05", first_name: "Jennifer", last_name: "Ferreira", birth: "27-12-1966", crypted_password: "NoocMuGOmd", phone: "(81) 98525-9247", role_id: 2)
User.create(cpf: "425.775.022-73", first_name: "Lívia", last_name: "Porto", birth: "09-10-1995", crypted_password: "OX0xFlTG1l", phone: "(61) 99601-7196", role_id: 2)
User.create(cpf: "925.042.139-72", first_name: "Luiza", last_name: "Peixoto", birth: "21-09-1983", crypted_password: "XJG4JiKU6E", phone: "(42) 98991-2418", role_id: 2)
User.create(cpf: "212.224.743-60", first_name: "Murilo", last_name: "Pinto", birth: "06-03-1967", crypted_password: "6LxMZEqGhA", phone: "(48) 99322-7596", role_id: 2)
User.create(cpf: "772.909.596-39", first_name: "Levi", last_name: "Moura", birth: "21-04-1995", crypted_password: "j0CxwIxSHZ", phone: "(61) 98225-2512", role_id: 2)
User.create(cpf: "067.210.822-41", first_name: "Aurora", last_name: "Souza", birth: "02-02-1963", crypted_password: "dhiMyrNn9d", phone: "(41) 98852-4959", role_id: 2)
User.create(cpf: "643.982.487-22", first_name: "Ricardo", last_name: "Cunha", birth: "15-10-1988", crypted_password: "bMpzHiHiX3", phone: "(92) 98793-4551", role_id: 2)
User.create(cpf: "928.963.525-89", first_name: "Maitê", last_name: "Campos", birth: "04-02-1943", crypted_password: "d3w0ZCYWgl", phone: "(95) 99740-7690", role_id: 2)
User.create(cpf: "188.686.287-75", first_name: "Julia", last_name: "Martins", birth: "22-11-2000", crypted_password: "INdC0TsEIe", phone: "(84) 99645-5906", role_id: 2)
User.create(cpf: "885.231.237-41", first_name: "Ricardo", last_name: "Pires", birth: "13-05-1970", crypted_password: "AkBi2XqGtd", phone: "(83) 99629-0072", role_id: 2)
User.create(cpf: "211.511.583-05", first_name: "Carolina", last_name: "Vieira", birth: "12-03-1984", crypted_password: "zrp6PxHzqf", phone: "(77) 99628-9244", role_id: 2)
User.create(cpf: "777.067.302-04", first_name: "Oliver", last_name: "Rosa", birth: "08-04-2000", crypted_password: "ut2ixeQIhe", phone: "(21) 99132-1690", role_id: 2)
User.create(cpf: "920.341.942-09", first_name: "Natália", last_name: "Farias", birth: "15-07-1993", crypted_password: "4kg947L0Xc", phone: "(85) 99843-9963", role_id: 2)
User.create(cpf: "766.106.169-49", first_name: "Luan", last_name: "Dias", birth: "01-11-1967", crypted_password: "1r5h46JAkE", phone: "(11) 98756-3992", role_id: 2)
User.create(cpf: "197.660.663-29", first_name: "Lucca", last_name: "Barros", birth: "15-01-1997", crypted_password: "ZoWKWAPBok", phone: "(32) 98775-7443", role_id: 2)
User.create(cpf: "921.678.022-34", first_name: "Vanessa", last_name: "Pereira", birth: "17-03-1967", crypted_password: "lWMsBAlGR2", phone: "(67) 98632-1149", role_id: 2)
User.create(cpf: "234.545.941-70", first_name: "Henry", last_name: "Campos", birth: "09-03-1946", crypted_password: "KlkjGDIBhS", phone: "(48) 99146-4132", role_id: 2)
User.create(cpf: "280.745.887-42", first_name: "Francisco", last_name: "Mata", birth: "13-09-1946", crypted_password: "G14HjYnbPZ", phone: "(65) 99105-9150", role_id: 2)
User.create(cpf: "233.293.354-91", first_name: "Allana", last_name: "Viana", birth: "20-05-1943", crypted_password: "pgoE7BYg8F", phone: "(65) 99899-1311", role_id: 2)

s = School.create(name: 'Saberes', url: 'https://saberes.senado.leg.br', initials: 'SSL')
s.logo.attach(
    io: open('https://saberes.senado.leg.br/theme/image.php/ilb/theme/1539274492/logo_saberes_xl'),
    filename: 'logo_saberes.png',
    content_type: 'image/png'
)
s = School.create(name: 'EaD Senac', url: 'http://www.ead.senac.br/', initials: 'EAS')
s.logo.attach(
    io: open('http://folhadealagoas.com.br/portal/wp-content/uploads/2017/08/senac.jpg'),
    filename: 'logo_senac.jpg',
    content_type: 'image/jpg'
)
cat = CourseCategory.create(name: 'Meio Ambiente')
cat.logo.attach(
    io: open('https://static.todamateria.com.br/upload/te/rr/terra1.jpg'),
    filename: 'logo_cat_meio_ambiente.jpg',
    content_type: 'image/jpg'
)
cat = CourseCategory.create(name: 'Saúde')
cat.logo.attach(
    io: open('http://envolverde.cartacapital.com.br/wp-content/uploads/saude-1.jpg'),
    filename: 'logo_cat_saude.jpg',
    content_type: 'image/jpg'
)
cat = CourseCategory.create(name: 'Doutrinas Políticas')
cat.logo.attach(
    io: open('https://2.bp.blogspot.com/-4JP1mOWw2bk/WOqMTDF4keI/AAAAAAABR6g/dF8hEdmDoL8wH-Iz1VhQsyGFqGheiT0uACLcB/s1600/%252BPostagem%2B046.jpg'),
    filename: 'logo_cat_doutrinas_politicas.jpg'
)

Course.create(certificador: "ENAP", conteudista: "Unicorreios", carga_horaria: '20', name: 'Liberalismo', ead_id: '1', url: 'https://saberes.senado.leg.br/course/view.php?id=1381', school_id: 1, course_category_id: 3, course_load: 20, description: 'Definir, analisar e discutir o significado das principais correntes de pensamento que inspiram e orientam os partidos políticos de maior expressão - em termos de influência, voto e acesso ao poder - no mundo atual.')
Course.create(certificador: "ENAP", conteudista: "NUTEAD - UEPG", carga_horaria: '30', name: 'GESTÃO DA INFORMAÇÃO E DOCUMENTAÇÃO - CONCEITOS BÁSICOS EM GESTÃO DOCUMENTAL', ead_id: '2', url: 'https://saberes.senado.leg.br/course/view.php?id=1381', school_id: 1, course_category_id: 2, course_load: 20, description: 'Definir, analisar e discutir o significado das principais correntes de pensamento que inspiram e orientam os partidos políticos de maior expressão - em termos de influência, voto e acesso ao poder - no mundo atual.')
Course.create(certificador: "ENAP", conteudista: "OGU/CGU", carga_horaria: '35', name: 'ELABORAÇÃO DE PLANO DE DADOS ABERTOS', ead_id: '3', url: 'https://saberes.senado.leg.br/course/view.php?id=1381', school_id: 1, course_category_id: 1, course_load: 20, description: 'Definir, analisar e discutir o significado das principais correntes de pensamento que inspiram e orientam os partidos políticos de maior expressão - em termos de influência, voto e acesso ao poder - no mundo atual.')
Course.create(certificador: "ENAP", conteudista: "OGU/CGU", carga_horaria: '35', name: 'ACESSO À INFORMAÇÃO', ead_id: '3', url: 'https://saberes.senado.leg.br/course/view.php?id=1381', school_id: 1, course_category_id: 2, course_load: 20, description: 'Definir, analisar e discutir o significado das principais correntes de pensamento que inspiram e orientam os partidos políticos de maior expressão - em termos de influência, voto e acesso ao poder - no mundo atual.')
Course.create(certificador: "ENAP", conteudista: "OGU/CGU", carga_horaria: '35', name: 'NOÇÕES GERAIS DE DIREITOS AUTORAIS', ead_id: '3', url: 'https://saberes.senado.leg.br/course/view.php?id=1381', school_id: 1, course_category_id: 1, course_load: 20, description: 'Definir, analisar e discutir o significado das principais correntes de pensamento que inspiram e orientam os partidos políticos de maior expressão - em termos de influência, voto e acesso ao poder - no mundo atual.')

Certificate.create(course_id: '1', user_id: '1', issue_date: '2018-10-08T17:04:00.799Z', grade: '80.0', code_id: "1")
Certificate.create(course_id: '2', user_id: '1', issue_date: '2018-10-08T17:04:00.799Z', grade: '95.0', code_id: "1")
Certificate.create(course_id: '3', user_id: '1', issue_date: '2018-10-08T17:04:00.799Z', grade: '95.0', code_id: "1")

Certificate.create(course_id: '1', user_id: '2', issue_date: '2018-10-08T17:04:00.799Z', grade: '40.0', code_id: "1")
Certificate.create(course_id: '2', user_id: '2', issue_date: '2018-10-08T17:04:00.799Z', grade: '25.0', code_id: "1")
Certificate.create(course_id: '3', user_id: '2', issue_date: '2018-10-08T17:04:00.799Z', grade: '40.0', code_id: "1")

@conversa1 = ContactUsConversation.create(user_id: '1', type_conversation: "dúvida", title: "Não consigo acessar o moodle", was_answered: "false", school_initials: "SSL", course_id: "1", description: "O que fazer para ter acesso as aulas", cpf: "000.000.000-0", name: "Morfeus", email: "MorfeusNeo@gmail.com")
ContactUsConversation.create(user_id: '1', type_conversation: "reclamação", title: "O site apresenta um layout muito desagradável", was_answered: "false", school_initials: "HTT", course_id: "2", description: "O design do site poderia ser mudado para um modelo parecido com o do facebook.", cpf: "000.000.000-0", name: "Rezinaldo", email: "reizão@gmail.com")
ContactUsConversation.create(user_id: '2', type_conversation: "sugestão", title: "Melhorar o curso de Web", school_initials: "SSL", was_answered: "false", course_id: "1", description: "O curso de web poderia apresentar a linguagem javascript.", cpf: "000.000.000-01", name: "Zilmar", email: "Zilmar@gmail.com")
ContactUsConversation.create(user_id: '2', type_conversation: "dúvida", title: "Posso passar a senha do meu moodle para um amigo?", was_answered: "false", school_initials: "SSL", course_id: "1", description: "Gostaria de saber se eu posso passar a senha do moodle para que um amigo também possa participar das atividades.", cpf: "000.000.000-01", name: "Sassá", email: "sassa@gmail.com")

@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name: 'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'Tente acessar novamente, liberei o seu acesso.', is_student: 'false')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name: 'Morfeus', email: 'morfeusNeo@gmail.com', cpf: '4564564545', description: 'Tentei e continuo sem acesso.', is_student: 'true')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name: 'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'Tinha esquecido de liberar, agora pode tentar mesmo.', is_student: 'false')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name: 'Morfeus', email: 'morfeusNeo@gmail.com', cpf: '4564564545', description: 'Obrigado, agora eu consegui.', is_student: 'true')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name: 'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'De nada.', is_student: 'false')

CourseRegistrationStatus.create(status: 'Inicializado')
CourseRegistrationStatus.create(status: 'Inscrito')
@quiz = Quiz.create
@quiz_question = QuizQuestion.create(question: 'Estado em que reside', quiz_id: @quiz.id, tag: 'QUEST_UF_RESIDENCIA')
["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"].each do |estado|
  @quiz_answer1 = QuizAnswer.create(answer: estado, quiz_question_id: @quiz_question.id)
end

@quiz_question = QuizQuestion.create(question: 'Minha Principal Atividade Profissional', quiz_id: @quiz.id, tag: 'QUEST_ATIVIDADE_PROFISSIONAL')
['Servidor do Tribunal de Contas Estadual e/ou Municipal',
 'Outras categorias de funcionários públicos',
 'Servidor da Assembleia Legislativa',
 'Autônomo',
 'Servidor da Câmara Municipal',
 'Estudante',
 'Servidor do Poder Executivo',
 'Servidor da Câmara dos Deputados',
 'Servidor do Poder Judiciário',
 'Não pertenço a nenhuma das categorias acima',
 'Servidor do Senado Federal',
 'Iniciativa privada',
 'Servidor do Tribunal de Contas da União'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Gênero', quiz_id: @quiz.id, tag: 'QUEST_GENERO')
['Masculino', 'Feminino', 'Outro'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Idade', quiz_id: @quiz.id, tag: 'QUEST_IDADE')
['Acima de 65 anos',
 'De 55 a 65 anos',
 'Menos de 18 anos',
 'De 25 a 34 anos',
 'De 18 a 24 anos',
 'De 35 a 44 anos',
 'De 45 a 54 anos'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end

@quiz_question = QuizQuestion.create(question: 'Minha formação', quiz_id: @quiz.id, tag: 'QUEST_FORMACAO')
['Doutorado',
 'Graduação',
 'Mestrado',
 'Especialização',
 'Ensino Fundamental',
 'Ensino Médio'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Horas semanais que pretendo dedicar ao curso', quiz_id: @quiz.id, tag: 'QUEST_HORAS_DEDICAR_CURSO')
['De 21 a 30 horas',
 'De 31 a 40 horas',
 'Mais de 60 horas',
 'De 41 a 60 horas',
 'De 11 a 20 horas',
 'Até 10 horas'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Local que pretendo, preferencialmente, acessar o curso', quiz_id: @quiz.id, tag: 'QUEST_LOCAL_ACESSAR_CURSO')
['Trabalho',
 'Café',
 'Casa',
 'Lan house'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Principal ferramenta que devo utilizar para acessar o curso', quiz_id: @quiz.id, tag: 'QUEST_FERRAM_ACESSAR_CURSO')
['Desktop',
 'Celular',
 'Tablet',
 'Notebook'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Tenho experiência em cursos na modalidade a distância', quiz_id: @quiz.id, tag: 'QUEST_EXPERIENCIA_ANTERIOR_EAD')
['Sim.',
 'Não.'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end
@quiz_question = QuizQuestion.create(question: 'Minha principal motivação para realizar o curso', quiz_id: @quiz.id, tag: 'QUEST_MOTIVACAO_PRINCIPAL')
['Obtenção do material instrucional',
 'Curiosidade',
 'Complementação de carga horária IES',
 'Licença capacitação',
 'Progressão funcional',
 'Adicional de especialização',
 'Obtenção de certificado',
 'Capacitação profissional'].each do |v|
  @quiz_answer1 = QuizAnswer.create(answer: v, quiz_question_id: @quiz_question.id)
end

ApiAccessLevel.create(name: "Incomplete")
ApiAccessLevel.create(name: "UserData")
ApiAccessLevel.create(name: "BasicApiControl")
ApiAccessLevel.create(name: "FullApiControl")