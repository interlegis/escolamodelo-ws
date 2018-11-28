
require 'open-uri'
Role.create(name: 'admin')
Role.create(name: 'usuario')
  User.create(first_name: 'Admin', last_name: 'Admin', cpf: '000.000.000-00', phone: '(00) 90000-0000', email: 'admin@admin.com', role_id: 1, password: 'admin123')
  User.create(first_name: 'Ronaldinho', last_name: 'Gaúcho', cpf: '000.000.000-01', phone: '(00) 90000-0001', email: 'ronaldinho@gaucho.com', role_id: 1, password: 'ronaldinho123')
s=School.create(name: 'Saberes', url: 'https://saberes.senado.leg.br', initials: 'SSL')
s.logo.attach(
    io: open('https://saberes.senado.leg.br/theme/image.php/ilb/theme/1539274492/logo_saberes_xl'),
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

@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'Tente acessar novamente, liberei o seu acesso.', is_student: 'false')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Morfeus', email: 'morfeusNeo@gmail.com', cpf: '4564564545', description: 'Tentei e continuo sem acesso.', is_student: 'true')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'Tinha esquecido de liberar, agora pode tentar mesmo.', is_student: 'false')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Morfeus', email: 'morfeusNeo@gmail.com', cpf: '4564564545', description: 'Obrigado, agora eu consegui.', is_student: 'true')
@conversa1.contact_us_message.create(contact_us_conversation_id: '1', name:'Gezimar', email: 'gezi@gmail.com', cpf: '4564564545', description: 'De nada.', is_student: 'false')

CourseRegistrationStatus.create(status: 'Inicializado')
CourseRegistrationStatus.create(status: 'Inscrito')
@quiz = Quiz.create
@quiz_question = QuizQuestion.create(question: 'Estado em que reside', quiz_id: @quiz.id, tag: 'QUEST_UF_RESIDENCIA')
["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"].each do |estado|
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