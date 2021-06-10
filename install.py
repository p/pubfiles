#!/usr/bin/env python3

import os.path, sys, subprocess, re

pub_root = os.path.dirname(__file__)
sys.path.append(os.path.join(pub_root, 'home/openbox/lib'))

import pyratemp

def mkdir_p(path):
    if not os.path.exists(path):
        os.mkdir(path)

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

def have(binary):
    for path in os.environ['PATH'].split(':'):
        bin_path = os.path.join(path, binary)
        if os.path.exists(bin_path) and os.stat(bin_path).st_mode & 0o111:
            return True
    return False

def is_laptop():
    if have('laptop-detect'):
        cp = subprocess.run(['laptop-detect'])
        if cp.returncode == 0:
            return True
        elif cp.returncode == 1:
            return False
        else:
            raise "Unexpected return code %s from laptop-detect" % cp.returncode
    
    return False

config = {}

if os.path.exists('/etc/setup.conf'):
    with open('/etc/setup.conf') as f:
        for line in f:
            if re.match(r'\s*#', line):
                continue
            k, v = line.strip().split('=', 1)
            if v == 'true':
                v = True
            elif v == 'false':
                v = False
            config[k] = v

def is_headful():
    try:
        return config['headful']
    except KeyError:
        return is_laptop()

abs_pub_root = os.path.abspath(pub_root)

mkdir_p(os.path.expanduser('~/.bin'))

if have('zsh'):
    ln_sf(os.path.join(abs_pub_root, 'home/zshenv'), os.path.expanduser('~/.zshenv'))
    
    target_path = os.path.expanduser('~/.zshrc')
    if not os.path.exists(target_path):
        cp(os.path.join(abs_pub_root, 'home/zshrc.sample'), target_path)

if have('git'):
    ln_sf(os.path.join(abs_pub_root, 'home/gitconfig'), os.path.expanduser('~/.gitconfig'))
    ln_sf(os.path.join(abs_pub_root, 'home/gitignore'), os.path.expanduser('~/.gitignore'))

ln_sf(os.path.join(abs_pub_root, 'home/irbrc'), os.path.expanduser('~/.irbrc'))
ln_sf(os.path.join(abs_pub_root, 'home/gemrc'), os.path.expanduser('~/.gemrc'))

mkdir_p(os.path.join(abs_pub_root, 'home/config'))
mkdir_p(os.path.expanduser('~/.config'))

if is_headful():
    template = pyratemp.Template(filename=os.path.join(abs_pub_root, 'home/xinitrc.tpl'))
    gen = template(pub_root=abs_pub_root)

    home_xinitrc = os.path.expanduser('~/.xinitrc')
    print('Writing %s' % home_xinitrc)
    if os.path.islink(home_xinitrc):
        os.unlink(home_xinitrc)

    with open(home_xinitrc, 'w') as f:
        f.write(gen)

    if have('xscreensaver'):
        ln_sf(os.path.join(abs_pub_root, 'home/xscreensaver'), os.path.expanduser('~/.xscreensaver'))

    ln_sf(os.path.join(abs_pub_root, 'home/SciTEUser.properties'), os.path.expanduser('~/.SciTEUser.properties'))
    ln_sf(os.path.join(abs_pub_root, 'home/gtkterm2rc'), os.path.expanduser('~/.gtkterm2rc'))

    ln_sf(os.path.join(abs_pub_root, 'home/config/user-dirs.dirs'), os.path.expanduser('~/.config/user-dirs.dirs'))
