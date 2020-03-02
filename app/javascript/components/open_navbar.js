let openNavbar = () => {
  const openbtn = document.querySelector(".openbtn")

  openbtn.addEventListener('click', () => {
    document.getElementById("myNavbar").style.width = "100%";
    document.getElementById("main").style.display = "none";
  });
}

export { openNavbar };
