try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen
import json, sys, re, subprocess, os.path

class BranchLookupError(Exception): pass
class UnexpectedBranchName(Exception): pass
class UnexpectedRemoteUrl(Exception): pass

def get_current_branch():
    output = subprocess.check_output(['git', 'branch'])
    branch = None
    for line in output.decode().split("\n"):
        if line[0] == '*':
            branch = line[1:].strip()
            break
            
    if branch is None:
        raise BranchLookupError('Cannot figure out current branch')
        
    return branch

def get_current_pr_num():
    branch = get_current_branch()
    match = re.match(r'pr-(\d+)$', branch)
    if match is None:
        raise UnexpectedBranchName('Current branch is not of pr-123 format')

    pr_num = int(match.group(1))
    return pr_num

def get_remote_names():
    output = subprocess.check_output(['git', 'remote', '-v'])
    lines = output.decode().strip().split("\n")
    names = [line.split("\t")[0] for line in lines]
    return names

def get_upstream_remote_name():
    names = get_remote_names()

    if 'upstream' in names:
        name = 'upstream'
    elif 'origin' in names:
        name = 'origin'
    else:
        raise RemoteLookupError('Cannot determine the upstream remote')
        
    return name

def get_remote_push_url(remote_name):
    return get_remote_url(remote_name, 'push')

def get_remote_fetch_url(remote_name):
    return get_remote_url(remote_name, 'fetch')

def get_remote_url(remote_name, kind):
    output = subprocess.check_output(['git', 'remote', '-v'])
    lines = output.decode().strip().split("\n")
    
    remote_url = None
    for line in lines:
        name, url, which = re.split(r'\s+', line)
        if name == remote_name:
            if which == '(%s)' % kind:
                remote_url = url
                break

    if remote_url is None:
        raise RemoteLookupError('Cannot find remote %s' % remote_name)
        
    return remote_url

def split_github_url(remote_url):
    match = re.match(r'git@github.com:([\w-]+)/([\w-]+?)(.git)?$', remote_url)
    if match is None:
        match = re.match(r'https://github.com/([\w-]+)/([\w-]+?)(.git|/)?$', remote_url)
        if match is None:
            raise UnexpectedRemoteUrl("Weird url: %s" % remote_url)
    
    return match.group(1), match.group(2)

def get_pr_info(upstream_owner_name, upstream_repo_name, pr_num):
    api_url = 'https://api.github.com/repos/%s/%s/pulls/%s' % (upstream_owner_name, upstream_repo_name, pr_num)
    print(api_url)

    c = urlopen(api_url).read()
    payload = json.loads(c)

    pr_owner_name = payload['head']['user']['login']
    pr_repo_name = payload['head']['repo']['name']
    pr_branch = payload['head']['ref']
    
    return pr_owner_name, pr_repo_name, pr_branch
