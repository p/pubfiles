#!/usr/bin/env python3

import os.path, re, tempfile

global_paths = ['/usr/share/iceweasel/browser/defaults/preferences/firefox.js']

def global_content():
    with open('user.js') as f:
        content = f.read()
    regexp = re.compile(r'^user_pref\(', re.M)
    # also: defaultPref, lockPref
    #content = regexp.sub('pref(', content)
    content = '''\
// Generated content - do not edit
%s
// End generated content
''' % content
    return content

def fix(path):
    with open(path) as f:
        content = f.read()
    regexp = re.compile(r'^// Generated content - do not edit$(.|\n)*^// End generated content\n', re.M)
    if regexp.search(content):
        print('found')
        content = regexp.sub(global_content(), content)
    else:
        content += "\n" + global_content()
    dir = tempfile.mkdtemp()
    new_path = os.path.join(dir, 'prefs.js')
    with open(new_path, 'w') as f:
        f.write(content)
    print('Saved new content to %s. Install via:\ncat %s > %s' % (new_path, new_path, path))

for path in global_paths:
    if os.path.exists(path):
        fix(path)
        break
else:
    print('ok')
