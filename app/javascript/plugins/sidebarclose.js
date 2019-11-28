 const closeNav = () => {
    console.log('close', document.getElementById("mySidebar"))
   document.getElementById("mySidebar").style.width = "0";
   document.getElementById("main").style.marginLeft = "0";
 }

 const closeSideBar = () => {
   const closeNavBtn = document.querySelector('.openbtn');
//   // console.log(closeNavBtn)
const openSidebar = document.getElementById("mySidebar")
//   // if (closeNavBtn == null) return;
  document.getElementById("mySidebar") == 'close'
    if (openSidebar.style.width == '0') return;
   closeNavBtn.addEventListener('click', closeNav);
 };

// export default closeSideBar;
