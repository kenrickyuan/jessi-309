// /* Set the width of the sidebar to 250px and the left margin of the page content to 250px */
  const openNav = () => {
    console.log('open', document.getElementById("mySidebar"))
    document.getElementById("mySidebar").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
  }



 const openSideBar = () => {
  const openNavBtn = document.querySelector('.openbtn');
 if (closeSideBar.style.width == '250px') return;
   openNavBtn.addEventListener('click', openNav);
 };

// console.log("hellofromoutside")

/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
// const sideBar = document.querySelector('.sidebar')
// export default openSideBar;
const sideBtn = document.querySelector(".openbtn");
const sideBar = document.getElementById("mySidebar");
 toggleBtn = document.querySelector(".openbtn");
   toggleBtn.addEventListener("click", (event) => {
    sideBar.classList.toggle("toggleSidebar");
     console.log(sideBtn.classList.toggle("toggleSidebtn"));
   });
//class Side {
 // open() {
  //   document.getElementById("mySidebar").style.width = "250px";
//   }
//   close() {
//   document.getElementById("mySidebar").style.width = "0";
//   }
// }

// myBar = new Side();
// if (myBar.open)
// document.getElementById("demo").innerHTML = myBar.present("Hello");

