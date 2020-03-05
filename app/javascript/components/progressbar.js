let displayProgressBar = () => {
  const displaybtn = document.querySelector(".progressbar-btn");
  if (displaybtn != null ) {
    displaybtn.addEventListener('click', () => {
      const progressbar = document.getElementById('progressbar');
      progressbar.style.display = "block";
    });
  }
}

export { displayProgressBar };
