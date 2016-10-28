var css = '\
#main article .x.x-long.x-secondary, #sidebar-oreilly, .oreilly-callout, #single-social {\
    display: none;\
}\
.fixed #masthead-title { position: static; }\
'

var style = document.createElement('style')
style.appendChild(document.createTextNode(css))
document.getElementsByTagName('head')[0].appendChild(style)
