export const scrollVisitDown = () => {
 let anchor = document.querySelector('.anchor');
  if (anchor) {
    window.scrollBy(0, -window.innerHeight /2);
  }
}
