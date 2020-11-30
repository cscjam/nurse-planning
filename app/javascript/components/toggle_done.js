export const toggleDone = () => {
  document.querySelectorAll(".toggle").forEach(element => {
    element.addEventListener("click", (event) => {
      if (element.classList.contains("done")) {
        element.classList.remove("done")
        element.classList.add("not-done")
      } else {
        element.classList.remove("not-done")
        element.classList.add("done")
      }
    })
  })
}
