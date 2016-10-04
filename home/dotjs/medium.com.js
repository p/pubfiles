var css = "\
/* top bar */ \
.metabar { position: static !important } \
/* bottom bar */ \
.postActionsBar { display: none !important; } \
/* right bottom popup with author's name */ \
.promoCardWrapper { display: none !important; } \
";

var style = document.createElement('style')
style.appendChild(document.createTextNode(css))
document.getElementsByTagName('head')[0].appendChild(style)
