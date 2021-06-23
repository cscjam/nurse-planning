import {fetchWithToken} from '../middleware/fetch_with_token'

export const toggleDone = () => {
  document.querySelectorAll(".toggle").forEach(element => {
    element.addEventListener("click", (event) => {
      if (element.classList.contains("done")) {
        element.classList.replace("done", "not-done")
        element.classList.replace("fa-check-circle", "fa-circle")
      } else {
        element.classList.replace("not-done", "done")
        element.classList.replace("fa-circle", "fa-check-circle" )
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


      // if (element.classList.contains("done")) {
      //   element.classList.replace("done", "not-done")
      //   element.classList.replace("fa-check-circle", "fa-circle")
      // } else {
      //   element.classList.replace("not-done", "done")
      //   element.classList.replace("fa-circle", "fa-check-circle" )
      // }
