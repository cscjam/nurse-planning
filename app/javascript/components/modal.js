export const modal = () => {
  // Get the modal
  const modal = document.getElementById("myModal");

  // Get the image and insert it inside the modal - use its "alt" text as a caption
  const img = document.querySelectorAll("#myImg");
  const modalImg = document.getElementById("img01");
  img.forEach((item) => {
    item.onclick = function(){
    modal.style.display = "block";
    modalImg.src = this.src;
    }
  })

  // Get the <span> element that closes the modal
  const span = document.getElementsByClassName("close")[0];

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
    modal.style.display = "none";
  }
}
