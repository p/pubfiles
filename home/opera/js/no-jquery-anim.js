window.bsdpower = {};

window.bsdpower.ready = [];
window.bsdpower.check = function() {
  var state = document.readyState;
  if (state == 'loaded' || state == 'complete') {
      for (var i = 0; i < window.bsdpower.ready.length; ++i) {
        window.bsdpower.ready[i]();
      }
  } else {
    setTimeout(window.bsdpower.check, 250);
  }
};

setTimeout(window.bsdpower.check, 250);

window.bsdpower.ready.push(function() {
  if (window.jQuery) {
    window.jQuery.fx.off = true;
  }
});
