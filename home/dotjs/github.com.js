var css = '\
.pr-toolbar {\
    position: static !important;\
}\
'

var style = document.createElement('style')
style.appendChild(document.createTextNode(css))
document.getElementsByTagName('head')[0].appendChild(style)

$('.Popover.js-notice').remove();

$(document).scroll(function() {
    $('.is-stuck').removeClass('is-stuck');
})
$(function() {
    $('.is-stuck').removeClass('is-stuck');
})
