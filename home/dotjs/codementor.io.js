var css = '\
.welcome-mat, #subscribe-popout-modal {\
    display: none !important;\
}\
\
'

var style = document.createElement('style')
style.appendChild(document.createTextNode(css))
document.getElementsByTagName('head')[0].appendChild(style)
