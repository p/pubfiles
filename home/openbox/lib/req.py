import os

class Req:
    @property
    def left(self):
        return os.environ.has_key('LEFT')
    
    @property
    def center(self):
        return os.environ.has_key('CENTER')
    
    @property
    def right(self):
        return os.environ.has_key('RIGHT')
    
    @property
    def one(self):
        return os.environ['SCREENS'] == '1'
    
    @property
    def two(self):
        return os.environ['SCREENS'] == '2'
    
    @property
    def three(self):
        return os.environ['SCREENS'] == '3'
    
    @property
    def home(self):
        return os.environ['HOME']
    
    @property
    def browser_home(self):
        return '/home/browser'
    
    @property
    def laptop(self):
        return os.environ['LAPTOP'] in ['1', 'yes']
    
    @property
    def primary(self):
        return self.one
