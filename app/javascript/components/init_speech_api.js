export const initSpeechApi = () => {
  const speechElt = document.getElementById("speech");
  const recordBtn = document.querySelector(".fa-microphone");
  const pushBtn = document.getElementById ("minute-submit");

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
      speechElt.innerText = "";
      recognition.start();
    });
    recordBtn.addEventListener("mouseup", event => {
      recognition.stop();
    });
  }
};
