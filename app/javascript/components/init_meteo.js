export const initMeteoInfo = () => {
  const meteoInfoElt = document.getElementById('meteo-infos');
  const meteoIconElt = document.getElementById('meteo-icon');
  if(meteoInfoElt && meteoIconElt){
    let url = `https://api.openweathermap.org/data/2.5/weather?`
    url += `lat=${meteoInfoElt.dataset.lat}&`
    url += `lon=${meteoInfoElt.dataset.lng}&`
    url += `appid=b8c099dc37d2a5363fa8b8abf0568822`

    fetch(url)
      .then(response => response.json())
      .then((data) => {
        meteoInfoElt.innerText = `${Math.round(data.main.temp) - 273}°C`;
        meteoIconElt.src = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`;
      })
  }
}
