let closeNavbar = () => {
  const closebtn = document.querySelector(".closebtn")

  closebtn.addEventListener('click', () => {
    document.getElementById("myNavbar").style.width = "0";
    document.getElementById("main").style.display = "block";
  });
}

export { closeNavbar };
