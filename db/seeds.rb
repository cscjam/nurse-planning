puts "SEED > CLEAN DB"
[VisitCare, Care, Minute, Visit, User, Patient, Team].each(&:delete_all)
#--------------------------------------------------------------------
puts "SEED > ADD TEAMS"
parc_bordelais = Team.create!(name: "Cabinet du parc Bordelais")
parc_bourran = Team.create!(name: "Cabinet du parc Bouran")
#--------------------------------------------------------------------
puts "SEED > ADD USERS"
jackie = User.new(
  first_name: "Nurse",
  last_name: "JACKIE",
  email: "njackie@mail.com",
  password: "nurseplan",
  address: "avenue Carnot 33200 Bordeaux",
  team: parc_bordelais)
file = URI.open('https://streamondemandathome.com/wp-content/uploads/2016/01/NurseJackie.jpg')
jackie.avatar.attach(io: file, filename: 'Nurse Jackie', content_type: 'image/png')
jackie.save!
serge = User.new(
  first_name: "Serge",
  last_name: "BLANCO",
  email: "sblanco@mail.com",
  password: "nurseplan",
  address: "rue du Vélodrome 33200 Bordeaux",
  team: parc_bordelais)
file = URI.open('https://i.pinimg.com/236x/bd/5e/31/bd5e31d61b3cb58ed315e46ef257eb30--ballon-rugby.jpg')
serge.avatar.attach(io: file, filename: 'Serge Blanco', content_type: 'image/png')
serge.save!
 #--------------------------------------------------------------------
puts "SEED > ADD PATIENTS"
alain = Patient.create!(
  first_name: "Alain",
  last_name: "JUPPE",
  address: "34 rue du Parc 33200 Bordeaux ",
  compl_address: "Appeler avant de sonner",
  phone: "+33666666666",
  team: parc_bordelais)
pierre = Patient.create!(
  first_name: "Pierre",
  last_name: "HURMIC",
  address: "12 rue Falquet 33200 Bordeaux ",
  compl_address: "Chien méchant",
  phone: "06 66 66 66 66",
  team: parc_bordelais)
nicolas = Patient.create!(
  first_name: "Nicolas",
  last_name: "FLORIAN",
  address: "3 rue Pasteur 33200 Bordeaux ",
  compl_address: "",
  phone: "0666666666",
  team: parc_bordelais)
hugues = Patient.create!(
  first_name: "Hugues",
  last_name: "MARTIN",
  address: "401 avenue de la Libération 33200 Bordeaux",
  compl_address: "",
  phone: "06.66.66.66.66",
  team: parc_bordelais)
jacques = Patient.create!(
  first_name: "Jacques ",
  last_name: "CHABAN DELMAS",
  address: "172 rue de l'École Normale 33200 Bordeaux",
  compl_address: "",
  phone: "06.66.66.66.66",
  team: parc_bordelais)
fernand = Patient.create!(
  first_name: "Fernand ",
  last_name: "AUDEGUIL",
  address: "Villa Primerose 33200 Bordeaux",
  compl_address: "",
  phone: "06 666 666 66",
  team: parc_bordelais)
#--------------------------------------------------------------------
puts "SEED > ADD VISITES"

patients = Patient.all
delays = (-2..-1).to_a + (1..5).to_a
delays.each do |day|
  position = 0
  (8..16).to_a.sample.times do
    Visit.create!(
      date: Date.today - day,
      position: position +=1 ,
      time: nil,
      wish_time: (6..20).to_a.sample,
      user: jackie,
      patient: patients.sample,
      is_done: true)
  end
end

position = 0
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 8,
  user: jackie,
  patient: alain,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 8,
  user: jackie,
  patient: pierre,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 9,
  user: jackie,
  patient: nicolas,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 9,
  user: jackie,
  patient: hugues,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 10,
  user: jackie,
  patient: jacques,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 10,
  user: jackie,
  patient: fernand,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 17,
  user: jackie,
  patient: alain,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 17,
  user: jackie,
  patient: pierre,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 18,
  user: jackie,
  patient: nicolas,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 18,
  user: jackie,
  patient: hugues,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 19,
  user: jackie,
  patient: jacques,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 19,
  user: jackie,
  patient: fernand,
  is_done: false)

#--------------------------------------------------------------------
# Injection, Prise de sang, perfusion, alimentation gastro, CHimio
puts "SEED > ADD CARES"
Care.create!(
    name: "Toilette",
    duration: "20",
    icon: "fas fa-hand-sparkles"
)
Care.create!(
    name: "Pansement",
    duration: "10",
    icon: "fas fa-band-aid"
)
Care.create!(
    name: "Insuline",
    duration: "5",
    icon: "fas fa-syringe"
)
Care.create!(
    name: "Diabete",
    duration: "5",
    icon: "fas fa-candy-cane"
)
Care.create!(
    name: "Traitement",
    duration: "5",
    icon: "fas fa-prescription-bottle"
)
Care.create!(
    name: "Pillulier",
    duration: "15",
    icon: "fas fa-pills"
)
#--------------------------------------------------------------------
puts "SEED > ADD VISITS-CARES"
visits = Visit.all
cares = Care.all
visits.each do |visit|
  (1..4).to_a.sample.times do
    VisitCare.create!(
      visit: visit,
      care: cares.sample
    )
  end
end
#--------------------------------------------------------------------
puts "SEED > ADD MNINUTES"
cr = [
  "La cicatrisation du patient se fait normalement, un suivi est à faire jusqu'à la date de fin.",
  "Le patient montre des signes d'instabilité. Il faut joindre le medecin traitant.",
  "Le traitement semble parfaitement adapté aprés l'ajustement fait avec le medecin traitant.",
  "La cicatrice du patient est gonflée. Si cela ne s'améliore pas d'ici la prochaine visite, il faudra prévoir une hospitalisation.",
  "La tension du patient est basse, il faut continuer de la prendre et alerter la famille si cela se dégrade.",
  "Le patient n'a plus d'ordonnance, nous n'avons pas pu facturer. Penser à metter à jours l'ordo et le logiciel.",
  "La visite du jour n'a pas été faite, le patient n'était pas à son domicile.",
  "Le patient n'est plus cohérent, le maintient à domicile est difficile. Alerter la famille et le medecin pour un placement.",
  "Dernière visite avec le patient pour le pansement. Aucune action nécéssaire.",
  "Le pillulier a été refait pour la semaine. Le traitement principal nécéssite un renouvellement",
  "L'insuline n'a pas été nécéssaire, car le patient presentait des taux satisfaisant. Pousuivre le control",
  "Une toilette au lit a été réalisée. Prévoir une douche à la prochaine visite",
  "Le service de dépôt de repas n'etait pas passé, j'ai dû prévenir la famille. Alerte glycémique",
  "La cicatrice de l'abdominoplastie est douloureuse pour le patient. A surveiller.",
]
visits.each do |visit|
  Minute.create!(
    visit: visit,
    content: cr.sample
  )
end
#--------------------------------------------------------------------
