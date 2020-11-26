// TODO: classic layout
// https://greasyfork.org/scripts/406160-github-com-classic-layout/code/GitHubcom:%20classic%20layout.user.js#bypass=true

var css = '\
.pr-toolbar {\
    position: static !important;\
}\
.Popover.js-notice, .Popover-message { display: none !important }\
'

var style = document.createElement('style')
style.appendChild(document.createTextNode(css))
document.getElementsByTagName('head')[0].appendChild(style)

$(document).scroll(function() {
    $('.is-stuck').removeClass('is-stuck');
})
$(function() {
    $('.is-stuck').removeClass('is-stuck');
})
