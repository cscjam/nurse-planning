export const initPhotoLoader = () => {
  // const eltRealPhotoSelector = document.getElementById("real-photo-selector");
  const eltRealPhotoSelector = document.querySelector("#minute_photos");
  const eltFakePhotoSelector = document.getElementById("fake-photo-selector");
  const eltSubmit = document.getElementById("new_minute");
  if(eltFakePhotoSelector && eltRealPhotoSelector && eltSubmit) {
    eltFakePhotoSelector.addEventListener("click", (event)=> {
      // debugger;
      eltRealPhotoSelector.click();
      console.log ("click");
    });
    // ended, close
    eltRealPhotoSelector.addEventListener('change', (event) =>{
      console.debug ("js submit new minute");
      debugger;
      document.querySelector("#minute_photos ").form.submit();
      // document.querySelector('#minute_photos').files = event.dataTransfer.files;
      // document.getElementById("new_minute").submit();
      // document.getElementById("new_minute").submit();
    })
  };
};
