#!/usr/bin/env python3

import os.path
import sys
import subprocess
import tempfile
import shutil
import os
import merge

path = '/usr/local/share/opera/skin/unix_skin.zip'

dir = tempfile.mkdtemp()
try:
    cwd = os.getcwd()
    os.chdir(dir)
    try:
        subprocess.check_call(['unzip', path])
    finally:
        os.chdir(cwd)
    ini_path = os.path.join(dir, 'skin.ini')
    add_path = os.path.join(os.path.dirname(__file__), 'skin.ini')
    merge.adjust_content(add_path, ini_path)
    os.chdir(dir)
    try:
        subprocess.check_call(['zip', '-r', os.path.basename(path), '.'])
    finally:
        os.chdir(cwd)
    print("cp %s %s" % (os.path.join(dir, os.path.basename(path)), path))
    sys.stdin.readline()
finally:
    shutil.rmtree(dir)
