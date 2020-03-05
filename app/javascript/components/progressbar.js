
const progressBarDisplay = (event) => {
  if (progressbar.style.display == "none") {
    progressbar.style.display = "block";
    console.log('toto');
  }
  event.preventDefault();
}

// let progressBarDisplay = () => {
//   const displaybtn = document.querySelector(".progressbar-btn");
//       console.log('toto');
//   // if (displaybtn != null) {
//     displaybtn.addEventListener('submit', () => {
//       // event.preventDefault();
//       document.getElementById('progressbar').style.display = 'block';
//     });
//   // }
// };

export { progressBarDisplay };

