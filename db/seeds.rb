puts "SEED > CLEAN DB"
[VisitCare, Care, Minute, Visit, User, Patient, Team].each(&:delete_all)
#--------------------------------------------------------------------
puts "SEED > ADD TEAMS"
parc_bordelais = Team.create!(name: "Cabinet du parc Bordelais")
parc_bourran = Team.create!(name: "Cabinet du parc Bouran")
#--------------------------------------------------------------------
puts "SEED > ADD USERS"
jackie = User.create!(
  first_name: "Nurse",
  last_name: "JACKIE",
  email: "njackie@mail.com",
  password: "nurseplan",
  address: "avenue Carnot 33200 Bordeaux",
  team: parc_bordelais)
serge = User.create!(
  first_name: "Serge",
  last_name: "BLANCO",
  email: "sblanco@mail.com",
  password: "nurseplan",
  address: "rue du Vélodrome 33200 Bordeaux",
  team: parc_bordelais)
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
  compl_address: "Chien méchatn",
  phone: "06 66 66 66 66",
  team: parc_bordelais)
nicolas = Patient.create!(
  first_name: "Nicolas",
  last_name: "FLORIAN",
  address: "3 rue ¨Pasteur 33200 Bordeaux ",
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
# 2.times do |day|
#   position = 0
#   (8..16).to_a.sample.times do
#     Visit.create!(
#       date: Date.today - day,
#       position: position +=1 ,
#       time: nil,
#       wish_time: (6..20).to_a.sample,
#       user: jackie,
#       patient: patients.sample,
#       is_done: true)
#   end
# end
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
# patients = Patient.all
# 5.times do |day|
#   position = 0
#   (4..16).to_a.sample.times do
#     Visit.create!(
#       date: Date.today + day,
#       position: position += 1,
#       time: nil,
#       wish_time: (6..20).to_a.sample,
#       user: jackie,
#       patient: patients.sample,
#       is_done: false)
#   end
# end
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
      visit: visits.sample,
      care: cares.sample
    )
  end
end
#--------------------------------------------------------------------
puts "SEED > ADD MNINUTES"
visits.each do |visit|
  Minute.create!(
    visit: visit,
    content: "Aute reprehenderit reprehenderit sint in in. Consequat aliqua proident sunt quis amet elit officia. Consequat deserunt et laboris ad cupidatat nostrud cupidatat non reprehenderit esse nisi ea proident cillum. Aute laboris sint adipisicing non ullamco eu exercitation ea id."
  )
end
#--------------------------------------------------------------------


