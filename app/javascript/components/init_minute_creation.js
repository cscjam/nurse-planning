export const initMinuteCreation = () => {
  const pushBtn = document.getElementById ("minute-submit");

  const uploadPhotoBtn = document.getElementById ("minute_photos");
  if (uploadPhotoBtn){
    uploadPhotoBtn.addEventListener("change", (event) => {
      pushBtn.click();
    })
  }
};
