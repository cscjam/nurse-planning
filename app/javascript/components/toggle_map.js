export const toggleMap = () => {
  const chevronMaps = document.querySelectorAll(".chevron-map");

  chevronMaps.forEach((content) => {
    const map = content.querySelector(".map");
    const icon = content.querySelector(".fa-chevron-down");
    icon.addEventListener("click", (event) => {
      event.preventDefault();
      map.classList.toggle("d-none")
    });
  });
}
