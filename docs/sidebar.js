window.document.addEventListener("DOMContentLoaded", function (event) {
  // Room
  const roomSpan = document.createElement('span')
    roomSpan.textContent = 'W 6:30-9, Car Barn 203'
    roomSpan.classList.add('sidebar-subtitle')
  const roomBr = document.createElement('br')
  // Term
  const termSpan = document.createElement('span')
    termSpan.textContent = 'Georgetown Fall 2026'
    termSpan.classList.add('sidebar-subtitle')
  const termBr = document.createElement('br')
  // Email
  const emailSpan = document.createElement('span')
    const emailText = 'Prof. Jeff Jacobs '
    const emailLink = document.createElement('a')
      emailLink.href = 'mailto:jj1088@georgetown.edu'
      emailLink.target = '_blank'
    const emailIcon = document.createElement('i')
      emailIcon.classList.add('bi')
      emailIcon.classList.add('bi-envelope-at')
      emailIcon.classList.add('ps-1')
      emailIcon.classList.add('pe-1')
    emailLink.appendChild(emailIcon)
    emailSpan.append(emailText, emailLink)
    emailSpan.classList.add('sidebar-subtitle')
  const emailBr = document.createElement('br')

  const sidebarDiv = document.getElementsByClassName('sidebar-title')[0]
  sidebarDiv.append(roomBr, roomSpan)
  sidebarDiv.append(termBr, termSpan)
  sidebarDiv.append(emailBr, emailSpan)
});
