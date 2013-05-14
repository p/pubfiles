if (window.FluidWeb && !window.FluidWeb.matched) {
  var width = window.innerWidth;
  var height = window.innerHeight;
  
  function addstyle(css) {
    var style = document.createElement('style');
    style.type = 'text/css';
    style.appendChild(document.createTextNode(css));
    document.getElementsByTagName('head')[0].appendChild(style);
  }

  width -= 20;
  var css = '* { max-width: ' + width + 'px !important; }';
  addstyle(css);
}
