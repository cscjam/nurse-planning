def load_avatar(instance, url)
  file = URI.open(url)
  instance.avatar.attach(io: file, filename: 'Nurse', content_type: 'image/png')
end


puts "SEED > CLEAN DB"
[VisitCare, Care, Minute, Visit, Prescription, Journey, User, Patient, Team].each(&:delete_all)
#--------------------------------------------------------------------
puts "SEED > ADD TEAMS"
parc_bordelais = Team.create!(name: "Cabinet du parc Bordelais")
parc_bourran = Team.create!(name: "Cabinet du parc Bouran")
#--------------------------------------------------------------------

puts "SEED > ADD USERS"
admin = User.new(
  first_name: "Nurse",
  last_name: "ADMIN",
  email: "admin@nurseplanning.com",
  password: "CGK1iu7hwU8RhfLSjrpH",
  address: "",
  team: nil,
  admin: true)
admin.save!
jackie = User.new(
  first_name: "Nurse",
  last_name: "JACKIE",
  email: "njackie@mail.com",
  password: "nurseplan",
  address: "avenue Carnot 33200 Bordeaux",
  team: parc_bordelais)
load_avatar(jackie, 'https://streamondemandathome.com/wp-content/uploads/2016/01/NurseJackie.jpg')
jackie.save!
sabatier = User.new(
  first_name: "J.Christophe",
  last_name: "SABATIER",
  email: "sabatier@mail.com",
  password: "nurseplan",
  address: "107 Cours Balguerie Stuttenberg, 33300 Bordeaux",
  team: parc_bordelais)
load_avatar(sabatier, 'https://avatars3.githubusercontent.com/u/70380868?v=4')
sabatier.save!
#--------------------------------------------------------------------
puts "SEED > ADD PATIENTS"
alain = Patient.create!(
  first_name: "Alain",
  last_name: "DUPOND",
  address: "34 rue du Parc 33200 Bordeaux ",
  compl_address: "Appeler avant de sonner",
  phone: "06 65 29 74 24",
  team: parc_bordelais)
pierre = Patient.create!(
  first_name: "Pierre",
  last_name: "DURAND",
  address: "12 rue Falquet 33200 Bordeaux ",
  compl_address: "Chien méchant",
  phone: "07 98 37 72 37",
  team: parc_bordelais)
nicolas = Patient.create!(
  first_name: "Nicolas",
  last_name: "MARTIN",
  address: "3 rue Pasteur 33200 Bordeaux ",
  compl_address: "Passer par le gardien",
  phone: "05 34 97 27 63",
  team: parc_bordelais)
hugues = Patient.create!(
  first_name: "Hugues",
  last_name: "CAPET",
  address: "401 avenue de la Libération 33200 Bordeaux",
  compl_address: "Sonner au 403",
  phone: "06 04 28 93 23",
  team: parc_bordelais)
jacques = Patient.create!(
  first_name: "Jacques ",
  last_name: "MESRIN",
  address: "172 rue de l'École Normale 33200 Bordeaux",
  compl_address: "",
  phone: "06 66 99 24 21",
  team: parc_bordelais)
fernand = Patient.create!(
  first_name: "Fernand ",
  last_name: "DELL",
  address: "27 rue Voltaire 33110 Bordeaux",
  compl_address: "",
  phone: "07 34 93 23 46",
  team: parc_bordelais)
roger = Patient.create!(
  first_name: "Roger ",
  last_name: "NAIN",
  address: "10 rue Ferbeyre 33200 Bordeaux",
  compl_address: "Code porte 3572A",
  phone: "07 00 93 23 67",
  team: parc_bordelais)
monique = Patient.create!(
  first_name: "Monique ",
  last_name: "RANOUX",
  address: "1 place du 14 juillet 33200 Bordeaux",
  compl_address: "Sonner à DURAND",
  phone: "06 34 12 23 46",
  team: parc_bordelais)

#--------------------------------------------------------------------
puts "SEED > ADD PRESCRIPTIONS"
pres1 = Prescription.create!(
  title: "pres1",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Lundi, Mercredi, Vendredi",
  patient_id: Patient.ids[0]
  )
pres2 = Prescription.create!(
  title: "pres2",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Mardi, Jeudi",
  patient_id: Patient.ids[1]
  )
pres3 = Prescription.create!(
  title: "pres3",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Mardi, Vendredi",
  patient_id: Patient.ids[2]
  )
pres4 = Prescription.create!(
  title: "pres4",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Lundi, Jeudi",
  patient_id: Patient.ids[3]
  )
pres5 = Prescription.create!(
  title: "pres5",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Mardi, Samedi",
  patient_id: Patient.ids[4]
  )
pres6 = Prescription.create!(
  title: "pres6",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Mardi",
  patient_id: Patient.ids[5]
  )
pres7 = Prescription.create!(
  title: "pres7",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Jeudi",
  patient_id: Patient.ids[6]
  )
pres8 = Prescription.create!(
  title: "pres8",
  start_at: Date.today,
  end_at: Date.today,
  schedule: "Jeudi, Dimanche",
  patient_id: Patient.ids[7]
  )
#--------------------------------------------------------------------
puts "SEED > ADD VISITES"
prescriptions = Prescription.all
delays = (-5..-1).to_a
delays.each do |day|
  position = 0
  wish_time = 5
  (8..16).to_a.sample.times do
    Visit.create!(
      date: Date.today + day,
      position: position +=1,
      time: nil,
      wish_time: wish_time += 1,
      user: jackie,
      prescription: prescriptions.sample,
      is_done: true)
  end
end
prescriptions = Prescription.all
delays = (1..5).to_a
delays.each do |day|
  position = 0
  wish_time = 5
  (8..16).to_a.sample.times do
    Visit.create!(
      date: Date.today + day,
      position: position +=1 ,
      time: nil,
      wish_time: wish_time += 1,
      user: sabatier,
      prescription: prescriptions.sample,
      is_done: false)
  end
end
#-------------------------------------------------------------------
puts "SEED > ADD VISITES"
position = -1
prescriptions = Prescription.all
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 8,
  user: sabatier,
  prescription: pres1,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 8,
  user: sabatier,
  prescription: pres2,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 9,
  user: sabatier,
  prescription: pres3,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 9,
  user: sabatier,
  prescription: pres4,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 10,
  user: sabatier,
  prescription: pres5,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 10,
  user: sabatier,
  prescription: pres6,
  is_done: true)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 11,
  user: sabatier,
  prescription: pres7,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 11,
  user: sabatier,
  prescription: pres8,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 12,
  user: sabatier,
  prescription: pres1,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 12,
  user: sabatier,
  prescription: pres2,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 14,
  user: sabatier,
  prescription: pres3,
  is_done: false)
Visit.create!(
  date: Date.today,
  position: position += 1,
  time: nil,
  wish_time: 14,
  user: sabatier,
  prescription: pres4,
  is_done: false)
#--------------------------------------------------------------------
# Injection, Prise de sang, perfusion, alimentation gastro, Chimio
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
compte_rendu =   ["La cicatrisation du patient se fait normalement, les fils sont à enlever à J12.",
  "Le patient montre des signes d’instabilité. Il faut joindre le medecin traitant." ,
  "Le traitement semble parfaitement adapté aprés l’ajustement fait avec le medecin traitant." ,
  "La cicatrice du patient est gonflée. Si cela ne s’améliore pas d’ici la prochaine visite, il faudra prévoir une hospitalisation." ,
  "La tension du patient est basse, il faut continuer de la prendre et alerter la famille si cela se dégrade." ,
  "Le patient n’a plus d’ordonnance, nous n’avons pas pu facturer. Penser à metter à jours l’ordo et le logiciel." ,
  "La visite du jour n’a pas été faite, le patient n’était pas à son domicile.",
  "Le patient n’est plus cohérent, le maintient à domicile est difficile. Alerter la famille et le medecin pour un placement." ,
  "Dernière visite avec le patient pour le pansement. Aucune action nécéssaire." ,
  "Le pillulier a été refait pour la semaine. Le traitement principal nécessite un renouvellement",
  "L'insuline pas été nécessaire, car le patient présentait des taux satisfaisant. Pousuivre le control",
  "Une toilette au lit a été réalisée. Prévoir une douche à la prochaine visite",
  "Le service de dépôt de repas n’etait pas passé, j’ai dû prévenir la famille. Alerte glycémique",
  "La cicatrice de l’abdominoplastie est douloureuse pour le patient. A surveiller.",
  "Bilan sang fait ce jour, INR1.98, poursuite des sous-cutanées.",
  "Regime alimentaire non suivi par le patient, augmentation de l’insuline lente du soir.",
  "Allergie au pansement de type allevyn, medecin prévenu pour prevision consultation.",
  "Ecoulement et inflammation aprés l’ablation d’agraphe. Pose d’un steristrip à surveiller.",
  "Le medecin traitant est passé pour modification du traitement mensuel. Ajout d’un anti-hypertenseur.",
  "Patient angoissé lors du passage ce jour, psy contacté pour planification consultation.",
  "Le patient vient de passer un scanner qui révèle un cancer du colon.",
  "Changement de socle+poche de colostomie ce jour, demain ne changer que la poche.",
  "Retrait de la chimiothérapie ce jour, point de ponction propre prochaine chimio le 02Fev.",
  "Patiente opérée d’une prothèse de hanche suite à une chute. Faire les sous-cut de lovenox pendant 1mois et control des plaquettes hebdo.",
 ]

visits = Visit.where(is_done: true)
visits.each do |visit|
  Minute.create!(
    visit: visit,
    content: compte_rendu.sample
  )
end
#--------------------------------------------------------------------
