window.document.addEventListener("DOMContentLoaded", function (event) {
  var roomHtml = "<span class='sidebar-subtitle'>Weds 6:30-9pm, Car Barn 204</span>";
  var termHtml = "<span class='sidebar-subtitle'>Georgetown Fall 2024</span>";
  var emailHtml = "<span class='sidebar-subtitle w-100'>Prof. Jeff Jacobs&nbsp;<a href='mailto:jj1088@georgetown.edu' target='_blank'><i class='bi bi-envelope-at ps-1 pe-1'></i></a></span>";
  var zoomIconBlack = "<svg xmlns='http://www.w3.org/2000/svg' x='0px' y='0px' width='22' height='22' viewBox='0 0 50 50'><path d='M33.619,4H16.381C9.554,4,4,9.554,4,16.381v17.238C4,40.446,9.554,46,16.381,46h17.238C40.446,46,46,40.446,46,33.619	V16.381C46,9.554,40.446,4,33.619,4z M30,30.386C30,31.278,29.278,32,28.386,32H15.005C12.793,32,11,30.207,11,27.995v-9.382	C11,17.722,11.722,17,12.614,17h13.382C28.207,17,30,18.793,30,21.005V30.386z M39,30.196c0,0.785-0.864,1.264-1.53,0.848l-5-3.125	C32.178,27.736,32,27.416,32,27.071v-5.141c0-0.345,0.178-0.665,0.47-0.848l5-3.125C38.136,17.54,39,18.019,39,18.804V30.196z'></path></svg>";
  // https://icons8.com/icon/set/zoom/group-color
  var zoomIconBlue = "<svg xmlns='http://www.w3.org/2000/svg' x='0px' y='0px' width='22' height='22' viewBox='0 0 48 48'><circle cx='24' cy='24' r='20' fill='#2196f3'></circle><path fill='#fff' d='M29,31H14c-1.657,0-3-1.343-3-3V17h15c1.657,0,3,1.343,3,3V31z'></path><polygon fill='#fff' points='37,31 31,27 31,21 37,17'></polygon></svg>";
  var zoomHtml = `<div class='sidebar-subtitle btn btn-outline-dark btn-block mt-2 mx-0 px-2 w-100 d-flex justify-content-center'><a href='https://georgetown.zoom.us/j/94074713027' target='_blank' class='icon-link' style='text-decoration: none !important;'><span class='icon ps-0'>${zoomIconBlue}</span><span class='flex-grow-1'>Zoom Link</span><i class='bi bi-box-arrow-up-right pe-1 ps-1 me-0' style='font-size: 85%;'></i></a></div>`;
  var subtitleDiv = $(`<br>${roomHtml}<br>${termHtml}<br>${emailHtml}<br>${zoomHtml}`);
    $('.sidebar-title').append(subtitleDiv);
});
