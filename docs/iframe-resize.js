document$.subscribe(function () {
  function sendHeight() {
    window.parent.postMessage(
      { height: document.documentElement.scrollHeight },
      "*",
    );
  }

  sendHeight();
  new ResizeObserver(sendHeight).observe(document.body);

  // Instant update on admonition open/close
  document.querySelectorAll("details").forEach((el) => {
    el.addEventListener("toggle", () => {
      // let the DOM settle first
      requestAnimationFrame(sendHeight);
    });
  });
});
