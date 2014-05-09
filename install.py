import os.path, sys

pub_root = os.path.dirname(__file__)
sys.path.append(os.path.join(pub_root, 'home/openbox/lib'))

import pyratemp

abs_pub_root = os.path.abspath(pub_root)
template = pyratemp.Template(filename=os.path.join(abs_pub_root, 'home/xinitrc.tpl'))
gen = template(pub_root=abs_pub_root)

home_xinitrc = os.path.expanduser('~/.xinitrc')
print('Writing %s' % home_xinitrc)
if os.path.islink(home_xinitrc):
    os.unlink(home_xinitrc)

with open(home_xinitrc, 'w') as f:
    f.write(gen)
