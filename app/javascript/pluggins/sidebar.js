/* Set the width of the sidebar to 250px and the left margin of the page content to 250px */
const openNav = () => {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
}

const openSideBar = () => {
  const openNavBtn = document.querySelector('#openbtn');
  if (openNavBtn == null) return;
  openNavBtn.addEventListener('click', console.log("hello"));
};

console.log("hellofromoutside")

/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */

export default openSideBar;

