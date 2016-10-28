// https://facebook.github.io/immutable-js/
var css = '\
.miniHeader { position: static; } \
'

// giant banner
css += '\
.coverContainer { display:none; } \
'

var style = document.createElement('style')
style.appendChild(document.createTextNode(css))
document.getElementsByTagName('head')[0].appendChild(style)
