import os.path, os

def run_as_browser(fn):
    def wrapped(*args, **kwargs):
        rv = fn(*args, **kwargs)
        return 'sudo -Hiu browser env XAUTHORITY=/home/browser/.Xauthority %s' % rv
    return wrapped

class Helpers:
    @property
    @run_as_browser
    def default_firefox_bin(self):
        candidates = [
            '/usr/local/lib/firefox/firefox-bin',
            '/usr/local/lib/firefox3/firefox-bin',
            '/usr/bin/iceweasel',
        ]
        return self._pick(candidates, os.path.exists)
    
    @property
    @run_as_browser
    def default_firefox_wrapper(self):
        candidates = [
            'firefox', 'firefox3'
        ]
        return self._pick(candidates, self._wrapper_tester)
    
    default_firefox = default_firefox_wrapper
    
    @property
    def as_browser(self):
        return 'sudo -Hiu browser'
    
    @property
    def opera(self):
        return 'sudo -Hiu browser opera'
    
    @property
    def chrome(self):
        return 'sudo -Hiu browser chrome'
    
    def have_bin(self, basename):
        return self._wrapper_tester(basename)
    
    def _wrapper_tester(self, candidate):
        dirs = os.environ['PATH'].split(':')
        for dir in dirs:
            path = os.path.join(dir, candidate)
            if os.path.exists(path):
                return True
        return False
        
    def _pick(self, candidates, tester):
        for candidate in candidates:
            if tester(candidate):
                return candidate
        # consider raising here
        return None
