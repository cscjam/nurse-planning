export const initPhotoLoader = () => {
  const eltRealPhotoSelector = document.getElementById("real-photo-selector");
  const eltFakePhotoSelector = document.getElementById("fake-photo-selector");
  const eltSubmit = document.getElementById("new_minute");
  if(eltFakePhotoSelector && eltRealPhotoSelector && eltSubmit) {
    eltFakePhotoSelector.addEventListener("click", (event)=> {
      eltRealPhotoSelector.click();
      console.log ("click");
    });
    // ended, close
    eltRealPhotoSelector.addEventListener('change', (event) =>{
      console.debug ("js submit new minute");
      document.getElementById("new_minute").submit();
    })
  };
};
