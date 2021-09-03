let items = document.querySelectorAll(".album_content ");
let container = document.querySelector(".album_wrap");
items.forEach(item => {
  item.addEventListener("mouseover", () => {
    container.style.background = "#ffffffde";
  });
  item.addEventListener("mouseleave", () => {
    container.style.background = "#e7e7e7e6";
  });
});


/*
let plantList = document.getElementById("plantList");
let petList = document.getElementById("petList");
let allList = document.getElementById("all");

plantList.addEventListener('click', () => {
  //console.log('plant만 불러오기');
  location.href = './personal_album_list.jsp?type=plant';
});
petList.addEventListener('click', () => {
  //console.log('pet만 불러오기');
  location.href = './personal_album_list.jsp?type=pet';
});
allList.addEventListener('click', () => {
  //console.log('모두 불러오기');
  location.href = './personal_album_list.jsp?type=all';
});
*/