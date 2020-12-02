export const toggleMap = () => {
  const chevronMaps = document.querySelectorAll(".chevron-map");

  chevronMaps.forEach((content) => {
    const map = content.querySelector(".map");
    const iconDw = content.querySelector(".fa-chevron-down");
    iconDw.addEventListener("click", (event) => {
      event.preventDefault();
      map.classList.toggle("d-none");
      iconDw.classList.toggle("fa-chevron-down");
      iconDw.classList.toggle("fa-chevron-up");
    });
  });
}
