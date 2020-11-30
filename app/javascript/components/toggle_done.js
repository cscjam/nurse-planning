import {fetchWithToken} from '../middleware/fetch_with_token'

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


