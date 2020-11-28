#!/usr/bin/env python3

import shutil
import functools
import optparse
import StringIO
import re
import ConfigParser
import os
import os.path
import subprocess

class CasePreservingConfigParser(ConfigParser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr

def adjust_perm(path):
    print('Adjusting permissions on %s' % path)
    
    # browser profiles may be symlinked in which case adjusting
    # the symlink won't do any good
    dir = os.path.dirname(os.path.realpath(path))
    subprocess.check_call(['sudo', '-u', 'browser', 'chmod', 'g+rwX', dir])
    # as we read the config file it needs to be readable
    if os.path.exists(path):
        subprocess.check_call(['sudo', '-u', 'browser', 'chmod', 'g+rw', path])

def adjust_content(add_path, path):
    print('Adjusting %s' % path)
    
    if os.path.exists(path):
        with open(path) as f:
            content = f.read()
        regexp = re.compile(r'([^\[]+)(.+)', re.S)
        match = regexp.match(content)
        assert match
        
        preamble = match.group(1)
        config = match.group(2)
    else:
        preamble = ''
        config = ''
    
    parser = CasePreservingConfigParser()
    if config != '':
        parser.readfp(StringIO.StringIO(config))
        assert len(parser.sections()) > 0
    
    add_parser = CasePreservingConfigParser()
    add_parser.read(add_path)
    assert len(add_parser.sections()) > 0
    
    for section in add_parser.sections():
        if section not in parser.sections():
            parser.add_section(section)
        for name, value in add_parser.items(section):
            parser.set(section, name, value)
    
    out = StringIO.StringIO()
    parser.write(out)
    
    with open(path, 'w') as f:
        f.write(preamble)
        f.write(out.getvalue())

def adjust(add_path, path):
    adjust_perm(path)
    adjust_content(add_path, path)

if __name__ == '__main__':
    add_path = os.path.join(os.path.dirname(__file__), 'operaprefs.ini')

    parser = optparse.OptionParser()
    parser.add_option('-p', '--perm', help='Adjust permissions only', action='store_true')
    options, args = parser.parse_args()
    if options.perm:
        fn = adjust_perm
    else:
        fn = functools.partial(adjust, add_path)

    root = '/home/browser'
    for entry in os.listdir(root):
        if entry.startswith('.opera'):
            path = os.path.join(root, entry)
            if os.path.exists(path):
                fn(os.path.join(path, 'operaprefs.ini'))
                if os.path.exists(os.path.join(path, 'search.ini')):
                    os.unlink(os.path.join(path, 'search.ini'))
                shutil.copy('search.ini', path)
