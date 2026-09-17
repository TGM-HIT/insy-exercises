document.addEventListener('DOMContentLoaded', () => {
  const btn = document.createElement('button');
  btn.id = 'chrome-toggle-btn';
  btn.textContent = 'Header/Footer anzeigen';
  document.body.appendChild(btn);

  btn.addEventListener('click', () => {
    const visible = document.body.classList.toggle('show-chrome');
    btn.textContent = visible
      ? 'Header/Footer ausblenden'
      : 'Header/Footer anzeigen';
  });
});