export const initSpeechApi = () => {
  const synthesisElts = document.querySelectorAll("#minute-content");
  const speechElt = document.getElementById("speech");
  const recordBtn = document.querySelector(".fa-microphone");

  // Voice Synthesis
  if(synthesisElts){
    synthesisElts.forEach(synthesisElt => {
      synthesisElt.addEventListener("click", event => {
        let text = new SpeechSynthesisUtterance(synthesisElt.innerText);
        speechSynthesis.speak(text);
      });
    });
  }
  // Voice Record
  if(speechElt && recordBtn ) {
    let recognizingStarted = false;
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
      document.getElementById("speech").innerText = event.results[0][0].transcript;
      if(document.getElementById ("minute-submit")){
        document.getElementById("minute-submit").click();
      }
    };
    recordBtn.addEventListener("mousedown", event => {
      speechElt.innerText = "";
      if (recognizingStarted){
        recognition.stop();
      }
      recognizingStarted = true
      recognition.start();
    });
    recordBtn.addEventListener("mouseup", event => {
      recognition.stop();
      recognizingStarted = false;
    });
  }
};
