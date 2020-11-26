export const initMinuteCreation = () => {
  const speechElt = document.getElementById("speech");
  const recordBtn = document.querySelector(".fa-microphone");
  const pushBtn = document.getElementById ("minute-submit");

  const uploadPhotoBtn = document.getElementById ("minute_photos");
  if (uploadPhotoBtn){
    uploadPhotoBtn.addEventListener("change", (event) => {
      pushBtn.click();
    })
  }

  if(speechElt && recordBtn && pushBtn) {
    const SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
    const recognition = new SpeechRecognition();
    recognition.lang = 'fr-FR';
    // Contrôle si la reconnaissance est continue, ou retourne seulement un seul résultat.
    recognition.continuous = true;
    // Contrôle si les résultats intermédiaires doivent être retournés (true) ou pas (false.)
    // Les résultats intermédiaires sont des résultats qui ne sont pas encore définitifs
    recognition.interimResults = false;
    // Règle le nombre maximum de SpeechRecognitionAlternative (d'alternatives) fourni par résultat.
    recognition.maxAlternatives = 1;

    recognition.onresult = function(event) {
      speechElt.innerText = event.results[0][0].transcript;
      pushBtn.click();
    };
    recordBtn.addEventListener("mousedown", event => {
      console.log("down");
      speechElt.innerText = "";
      recognition.start();
    });
    recordBtn.addEventListener("mouseup", event => {
      console.log("up");
      recognition.stop();
    });
  }
};
