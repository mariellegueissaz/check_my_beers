let displayProgressBarAdv = () => {
  const displaybtn = document.querySelector(".progressbar-btn-adv");
  if (displaybtn != null ) {
    displaybtn.addEventListener('click', () => {
      const progressbar = document.getElementById('progressbar');
      progressbar.style.display = "block";
    });
  }
}

export { displayProgressBarAdv };
