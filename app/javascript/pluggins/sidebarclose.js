const closeNav = () => {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft = "0";
}

const closeSideBar = () => {
  const closeNavBtn = document.getElementById('closebtn');
  console.log(closeNavBtn)
  if (closeNavBtn == null) return;
  closeNavBtn.addEventListener('click', closeNav);
};

export default closeSideBar;
