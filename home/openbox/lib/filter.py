import pyratemp
import req, helpers
import sys

text = sys.stdin.read()
template = pyratemp.Template(string=text)
print template(r=req.Req(), h=helpers.Helpers())
