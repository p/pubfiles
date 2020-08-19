#!/usr/bin/env python

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

def ln_sf(src, dest):
    print('Link %s to %s' % (src, dest))
    if os.path.exists(dest) or os.path.islink(dest):
        os.unlink(dest)
    os.symlink(src, dest)

def cp(src, dest):
    print('Copy %s to %s' % (src, dest))
    with open(dest, 'wb') as fw:
        with open(src, 'rb') as fr:
            fw.write(fr.read())

ln_sf(os.path.join(abs_pub_root, 'home/zshenv'), os.path.expanduser('~/.zshenv'))
ln_sf(os.path.join(abs_pub_root, 'home/gitconfig'), os.path.expanduser('~/.gitconfig'))
ln_sf(os.path.join(abs_pub_root, 'home/gitignore'), os.path.expanduser('~/.gitignore'))
ln_sf(os.path.join(abs_pub_root, 'home/SciTEUser.properties'), os.path.expanduser('~/.SciTEUser.properties'))
ln_sf(os.path.join(abs_pub_root, 'home/gtkterm2rc'), os.path.expanduser('~/.gtkterm2rc'))
ln_sf(os.path.join(abs_pub_root, 'home/irbrc'), os.path.expanduser('~/.irbrc'))
ln_sf(os.path.join(abs_pub_root, 'home/gemrc'), os.path.expanduser('~/.gemrc'))
if not os.path.exists(os.path.join(abs_pub_root, 'home/config')):
    os.mkdir(os.path.join(abs_pub_root, 'home/config'))
ln_sf(os.path.join(abs_pub_root, 'home/config/user-dirs.dirs'), os.path.expanduser('~/.config/user-dirs.dirs'))

target_path = os.path.expanduser('~/.zshrc')
if not os.path.exists(target_path):
    cp(os.path.join(abs_pub_root, 'home/zshrc.sample'), target_path)
