import {fetchWithToken} from '../middleware/fetch_with_token'

export const toggleDone = () => {
  document.querySelectorAll(".toggle").forEach(element => {
    element.addEventListener("click", (event) => {
      if (element.classList.contains("done")) {
        element.classList.remove("done")
        element.classList.add("not-done")
        element.innerHTML="<i class='far fa-circle'></i>"
      } else {
        element.classList.remove("not-done")
        element.classList.add("done")
        element.innerHTML="<i class='far fa-check-circle'></i>"
      }
      let id = element.dataset.id
      const url = `/visits/${id}/mark_as_done`

      fetchWithToken(url, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        method: 'PATCH',
        body: JSON.stringify( {} )
      })
    })
  })
}


