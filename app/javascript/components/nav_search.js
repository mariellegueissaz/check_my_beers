let openAdvancedSearch = () => {
  const openbtn = document.querySelector(".showbtn")
  if (openbtn != null ) {
    openbtn.addEventListener('click', () => {
      const x = document.getElementById("advanced-search");
        if (x.style.display === "none") {
          x.style.display = "block";
        } else {
          x.style.display = "none";
        }
    });
  }
}

export { openAdvancedSearch };
